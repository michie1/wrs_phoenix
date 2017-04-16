defmodule WrsPhoenix.RoomChannel do
  use Phoenix.Channel
  use Ecto.Model
  require Logger

  alias WrsPhoenix.Rider
  alias WrsPhoenix.Race
  alias WrsPhoenix.Result
  alias WrsPhoenix.Comment

  def join("room:lobby", _message, socket) do
    Logger.debug "join room:lobby"
    # {:ok, socket}
    {:ok, %{join: "success"}, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("init", %{}, socket) do
    Logger.debug "init"
    {:reply, {:ok, %{}}, socket}
  end

  def handle_in("riders", %{}, socket) do
    case WrsPhoenix.Repo.all(WrsPhoenix.Rider) do
      nil -> 
        {:reply, {:ok, %{}}, socket}

      riders -> 
        {:reply,
         {:ok,
          %{riders: riders_to_map(riders)}
         },
         socket
        }
    end
  end
  
  def handle_in("races", %{}, socket) do
    # case WrsPhoenix.Repo.all(WrsPhoenix.Race) do
    query = from(r in WrsPhoenix.Race, [order_by: [desc: r.date], limit: 100])
    case WrsPhoenix.Repo.all(query) do
      nil -> 
        {:reply, {:ok, %{}}, socket}

      races -> 
        {:reply,
         {:ok,
          %{races: races_to_map(races)}
         },
         socket
        }
    end
  end  

  def handle_in("results", %{}, socket) do
    # case WrsPhoenix.Repo.all(WrsPhoenix.Result) do
    query = from(r in WrsPhoenix.Result, [order_by: [desc: r.raceId], limit: 1000])
    case WrsPhoenix.Repo.all(query) do
      nil -> 
        {:reply, {:ok, %{}}, socket}

      results -> 
        {:reply,
         {:ok,
          %{results: results_to_map(results)}
         },
         socket
        }
    end
  end

  def handle_in("comments", %{}, socket) do
    case WrsPhoenix.Repo.all(WrsPhoenix.Comment) do
      nil -> 
        {:reply, {:ok, %{}}, socket}

      comments -> 
        {:reply,
         {:ok,
          %{comments: comments_to_map(comments)}
         },
         socket
        }
    end
  end

  def handle_in("createRider", payload, socket) do
    Logger.debug "payload value: #{inspect(payload)}"
    changeset = Rider.changeset(%Rider{}, %{name: payload["name"], licence: ""})

    case WrsPhoenix.Repo.insert(changeset) do
      {:ok, rider} ->
        Logger.debug "createdRider" 
        broadcast socket, "createdRider", %{id: rider.id, name: rider.name, licence: rider.licence}
        {:reply, {:ok, %{id: rider.id, name: rider.name}}, socket}
      {:error, changeset} ->
        {:reply, {:ok, %{hoi: "fout"}}, socket}
    end
  end

  def handle_in("createRace", payload, socket) do
    Logger.debug "payload value: #{inspect(payload)}"
    changeset = Race.changeset(%Race{}, %{name: payload["name"], date: payload["date"], category: payload["category"]})

    case WrsPhoenix.Repo.insert(changeset) do
      {:ok, race} ->
        Logger.debug "createdRace" 
        broadcast socket, "createdRace", %{id: race.id, name: race.name, date: race.date, category: race.category}
        {:reply, {:ok, %{id: race.id, name: race.name}}, socket}
      {:error, changeset} ->
        {:reply, {:ok, %{hoi: "fout"}}, socket}
    end
  end

  def handle_in("createResult", payload, socket) do
    Logger.debug "payload value: #{inspect(payload)}"
    changeset = Result.changeset(
      %Result{}, 
      %{riderId: payload["riderId"], 
        raceId: payload["raceId"], 
        result: payload["result"], 
        category: payload["category"], 
        strava: payload["strava"]
      })

    case WrsPhoenix.Repo.insert(changeset) do
      {:ok, result} ->
        Logger.debug "createdResult" 
        broadcast socket, "createdResult", %{id: result.id, riderId: result.riderId, raceId: result.raceId, result: result.result, category: result.category, strava: result.strava}
        {:reply, {:ok, %{id: result.id, raceId: result.raceId, result: result.result}}, socket}
      {:error, changeset} ->
        {:reply, {:ok, %{hoi: "fout"}}, socket}
    end
  end

  def handle_in("createComment", payload, socket) do
    Logger.debug "payload value: #{inspect(payload)}"
    changeset = Comment.changeset(
      %Comment{}, 
      %{riderId: payload["riderId"], 
        raceId: payload["raceId"], 
        text: payload["text"]
      })

    case WrsPhoenix.Repo.insert(changeset) do
      {:ok, comment} ->
        Logger.debug "createdComment" 
        broadcast socket, "createdComment", 
          %{id: comment.id, 
            riderId: comment.riderId, 
            raceId: comment.raceId, 
            text: comment.text,
            updatedAt: comment.updated_at
            } 
        {:reply, 
          {:ok, 
            %{id: comment.id,
              raceId: comment.raceId, 
              riderId: comment.riderId,
              text: comment.text,
              updatedAt: comment.updated_at
              }
           }, socket}

      {:error, changeset} ->
        {:reply, {:ok, %{hoi: "fout"}}, socket}
    end
  end

  def handle_in("updateRider", payload, socket) do
    Logger.debug "payload value: #{inspect(payload)}"

    rider = WrsPhoenix.Repo.get!(Rider, payload["id"])
    changeset = Rider.changeset(rider, %{licence: payload["licence"]})

    case WrsPhoenix.Repo.update(changeset) do
      {:ok, rider} ->
        broadcast socket, "updatedRider", %{id: rider.id, name: rider.name, licence: rider.licence}
        {:reply, {:ok, %{id: payload["id"], licence: payload["licence"]}}, socket}
      {:error, changeset} ->
        {:reply, {:ok, %{hoi: "fout"}}, socket}
    end

  end

  def handle_in("getStravaAccessToken", payload, socket) do
    Logger.debug "getStravaAccessToken"
    Logger.debug payload["code"]
    url = "https://www.strava.com/oauth/token"
    body = "client_id=1596&client_secret=95bb6e28af130c291c8b1437b5a51f01b94eb610&code=" <> payload["code"]
    Logger.debug body
    response = HTTPotion.post url, 
      [body: body,
       headers: ["User-Agent": "My App", "Content-Type": "application/x-www-form-urlencoded"]
      ]
    Logger.debug response.body
    {:reply, {:ok, %{body: response.body}}, socket}
  end

  defp riders_to_map(riders) do
    Enum.map(
      riders, 
      fn(rider) -> 
        %{
          id: rider.id,
          name: rider.name,
          licence: rider.licence
        } 
      end
    )
  end  

  defp races_to_map(races) do
    Enum.map(
      races, 
      fn(race) -> 
        %{
          id: race.id,
          name: race.name,
          date: race.date,
          category: race.category
        } 
      end
    )
  end

  defp results_to_map(results) do
    Enum.map(
      results, 
      fn(result) -> 
        %{
          id: result.id,
          riderId: result.riderId,
          raceId: result.raceId,
          category: result.category,
          result: result.result,
          strava: result.strava
        } 
      end
    )
  end

  defp comments_to_map(comments) do
    Enum.map(
      comments, 
      fn(comment) -> 
        %{
          id: comment.id,
          riderId: comment.riderId,
          raceId: comment.raceId,
          text: comment.text,
          updatedAt: comment.updated_at
        } 
      end
    )
  end
end
