class GoogleApi
  def get_value
    exclusion_list = ['Inactive', 'Work', 'Appointment']

    cal = init_google_api

    cal.login_with_auth_code('4/3kmFg0a42pu6v8c5wh3eKMD8eHDlbN0yubrY0N2jZ7Y')

    events = cal.find_events_in_range(DateTime.now.beginning_of_week, DateTime.now.beginning_of_week+7.days)

    exclusion_list.each do |exclusion|
      events.select!{ |e| e.title != exclusion }
    end
  end

  private

  def init_google_api
    Google::Calendar.new(
      :client_id     => '647362712493-n7ki1tnmgghpuu8thstbjcq9n7nsan8j.apps.googleusercontent.com',
      :client_secret => 'CVdICp8YLw2r4S5JZbYOEKff',
      :calendar      => 'aranzou@gmail.com',
      :redirect_url  => "urn:ietf:wg:oauth:2.0:oob" # this is what Google uses for 'applications'
    )
  end

end
