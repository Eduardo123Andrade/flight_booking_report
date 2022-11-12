defmodule FlightBookingReport.Bookings.CreateOrUpdate do
  alias FlightBookingReport.Bookings
  alias Bookings.Agent, as: BookingAgent
  alias Bookings.Booking
  alias FlightBookingReport.Users.Agent, as: UserAgent

  def call(%Booking{
        user_id: user_id,
        complete_date: complete_date,
        local_destination: local_destination,
        local_origin: local_origin
      }) do
    with {:ok, user} <- UserAgent.get(user_id),
         {:ok, booking} <- Booking.build(user.id, local_origin, local_destination, complete_date) do
      save_Booking(booking)
    end
  end

  defp save_Booking(%Booking{} = booking) do
    BookingAgent.save(booking)
    {:ok, "Booking created or updated successfully"}
  end
end
