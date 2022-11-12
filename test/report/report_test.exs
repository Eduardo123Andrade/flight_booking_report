defmodule FlightBookingReport.Report.ReportTest do
  use ExUnit.Case

  import FlightBookingReport.Factory

  alias FlightBookingReport.Bookings.Agent, as: BookingAgent
  alias FlightBookingReport.Report.Report

  describe "create/3" do
    setup %{} do
      BookingAgent.start_link()
      :ok
    end

    test "when initial date and final date is given, create the report file" do
      initial_date = ~N[2023-01-01 00:00:00]
      final_date = ~N[2023-01-03 00:00:00]
      filename = "report.csv"

      :booking
      |> build(complete_date: ~N[2023-01-01 00:00:00], user_id: 1)
      |> BookingAgent.save()

      :booking
      |> build(complete_date: ~N[2023-01-02 00:00:00], user_id: 2)
      |> BookingAgent.save()

      :booking
      |> build(complete_date: ~N[2023-01-03 00:00:00], user_id: 3)
      |> BookingAgent.save()

      :booking
      |> build(complete_date: ~N[2023-01-04 00:00:00], user_id: 4)
      |> BookingAgent.save()

      :booking
      |> build(complete_date: ~N[2023-01-05 00:00:00], user_id: 5)
      |> BookingAgent.save()

      Report.create(initial_date, final_date, filename)

      expected_response =
        "1,Winterfell,King's Landing,2023-01-01 00:00:00\n" <>
          "2,Winterfell,King's Landing,2023-01-02 00:00:00\n" <>
          "3,Winterfell,King's Landing,2023-01-03 00:00:00\n"

      response = File.read!("reports/#{filename}")

      assert expected_response == response
    end
  end
end
