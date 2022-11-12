defmodule FlightBookingReport.Report.Report do
  alias FlightBookingReport.Bookings.Agent, as: BookingAgent
  alias FlightBookingReport.Bookings.Booking

  def create(initial_date, final_date, filename \\ "report.csv") do
    path = "reports/#{filename}"

    booking_list = build_booking_list(initial_date, final_date)

    File.write!(path, booking_list)
  end

  defp build_booking_list(initial_date, final_date) do
    BookingAgent.get_all()
    |> Map.values()
    |> Enum.filter(&filter_booking(&1, initial_date, final_date))
    |> Enum.sort(&sort_booking/2)
    |> Enum.map(&booking_string/1)
  end

  defp sort_booking(
         %Booking{complete_date: complete_date1},
         %Booking{complete_date: complete_date2}
       ) do
    NaiveDateTime.compare(complete_date1, complete_date2) != :gt
  end

  defp filter_booking(%Booking{complete_date: complete_date}, initial_date, final_date) do
    complete_date >= initial_date && complete_date <= final_date
  end

  defp booking_string(%Booking{} = booking) do
    "#{booking.user_id},#{booking.local_origin},#{booking.local_destination},#{booking.complete_date}\n"
  end
end
