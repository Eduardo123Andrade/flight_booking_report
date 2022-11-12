defmodule FlightBookingReport.Bookings.Booking do
  @keys [:local_origin, :local_destination, :user_id, :id, :complete_date]
  @enforce_keys [:local_origin, :local_destination, :user_id, :complete_date]

  alias __MODULE__
  defstruct @keys

  def build(user_id, local_origin, local_destination, complete_date) do
    uuid = UUID.uuid4()
    local_date = NaiveDateTime.local_now()

    compare = NaiveDateTime.compare(complete_date, local_date)

    booking = %Booking{
      id: uuid,
      user_id: user_id,
      local_origin: local_origin,
      local_destination: local_destination,
      complete_date: complete_date
    }

    create_booking(booking, compare)
  end

  defp create_booking(%Booking{} = booking, compare) when compare == :gt, do: {:ok, booking}

  defp create_booking(_, _), do: {:error, "Invalid date"}
end
