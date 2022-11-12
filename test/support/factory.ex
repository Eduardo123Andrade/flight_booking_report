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

  def report_factory do
    build(:booking, complete_date: complete_date_sequence(), user_id: user_id_sequence())
  end

  defp complete_date_sequence() do
    sequence(:complete_date, &NaiveDateTime.from_iso8601!("2023-01-0#{&1} 00:00:00"), start_at: 1)
  end

  defp user_id_sequence() do
    sequence(:complete_date, & &1, start_at: 1)
  end
end
