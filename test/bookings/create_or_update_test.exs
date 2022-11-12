defmodule FlightBookingReport.Bookings.CreateOrUpdateTest do
  use ExUnit.Case

  import FlightBookingReport.Factory

  alias FlightBookingReport.Bookings.CreateOrUpdate
  alias FlightBookingReport.Bookings.Agent, as: BookingAgent

  alias FlightBookingReport.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      BookingAgent.start_link()
      UserAgent.start_link()

      user = build(:user)
      UserAgent.save(user)

      {:ok, user_id: user.id}
    end

    test "when all params are valid, save the booking", %{user_id: user_id} do
      response =
        :booking
        |> build(user_id: user_id)
        |> CreateOrUpdate.call()

      expected_response = {:ok, "Booking created or updated successfully"}

      assert response == expected_response
    end

    test "when there is no user with given id, return an error" do
      response =
        :booking
        |> build
        |> CreateOrUpdate.call()

      expected_response = {:error, "User not found"}

      assert expected_response == response
    end

    test "when pass a invalid date, return an error", %{user_id: user_id} do
      response =
        :booking
        |> build(user_id: user_id, complete_date: ~N[2020-01-01 00:00:00])
        |> CreateOrUpdate.call()

      expected_response = {:error, "Invalid date"}

      assert expected_response == response
    end
  end
end
