defmodule FlightBookingReport.Factory do
  use ExMachina

  alias FlightBookingReport.Users.User
  alias FlightBookingReport.Bookings.Booking

  def user_factory do
    uuid = UUID.uuid4()

    %User{
      cpf: "12312312312",
      email: "email@email.com",
      name: "Lord Stark",
      id: uuid
    }
  end

  def booking_factory do
    uuid = UUID.uuid4()
    %User{id: user_id} = build(:user)

    %Booking{
      id: uuid,
      local_origin: "Winterfell",
      local_destination: "King's Landing",
      complete_date: ~N[2024-01-01 22:00:00],
      user_id: user_id
    }
  end
end
