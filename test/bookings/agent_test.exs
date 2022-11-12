defmodule FlightBookingReport.Bookings.AgentTest do
  use ExUnit.Case

  import FlightBookingReport.Factory

  # alias FlightBookingReport.Bookings.CreateOrUpdate
  alias FlightBookingReport.Bookings.Agent, as: BookingAgent

  # alias FlightBookingReport.Users.Agent, as: UserAgent

  describe "save/1" do
    test "saves the flight booking" do
      booking = build(:booking)

      BookingAgent.start_link(%{})

      assert BookingAgent.save(booking) == :ok
    end
  end

  describe "get/1" do
    setup do
      BookingAgent.start_link()
      :ok
    end

    test "when the booking is found, return the booking" do
      booking = build(:booking)

      BookingAgent.save(booking)

      response = BookingAgent.get(booking.id)
      expected_response = {:ok, booking}

      assert response == expected_response
    end

    test "when the booking is not found, return an error" do
      wrong_id = UUID.uuid4()

      :booking
      |> build
      |> BookingAgent.save()

      response = BookingAgent.get(wrong_id)
      expected_response = {:error, "Booking not found"}

      assert response == expected_response
    end
  end
end
