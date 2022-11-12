defmodule FlightBookingReport do
  alias FlightBookingReport.Bookings.Agent, as: BookingAgent
  alias FlightBookingReport.Bookings.CreateOrUpdate, as: CreateOrUpdateBooking

  alias FlightBookingReport.Users.Agent, as: UserAgent
  alias FlightBookingReport.Users.CreateOrUpdate, as: CreateOrUpdateUser

  def start_agents() do
    UserAgent.start_link(%{})
    BookingAgent.start_link()
  end

  defdelegate create_or_update_booking(params), to: CreateOrUpdateBooking, as: :call

  defdelegate create_or_update_user(params), to: CreateOrUpdateUser, as: :call
end
