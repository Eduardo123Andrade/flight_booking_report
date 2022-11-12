defmodule FlightBookingReport.Bookings.BookingTest do
  use ExUnit.Case

  import FlightBookingReport.Factory

  alias FlightBookingReport.Bookings.Booking

  describe "build/4" do
    test "when all parameters are valid, return the booking" do
      user = build(:user)

      response = Booking.build(user.id, "Winterfell", "King's Landing", ~N[2024-01-01 22:00:00])

      # IO.inspect(response)
      {_, booking} = response

      expected_response = {:ok, build(:booking, user_id: booking.user_id, id: booking.id)}

      assert response == expected_response
    end

    test "when given invalid date, return an error" do
      user = build(:user)

      response = Booking.build(user.id, "Winterfell", "King's Landing", ~N[2020-01-01 22:00:00])

      expected_response = {:error, "Invalid date"}

      assert response == expected_response
    end
  end
end
