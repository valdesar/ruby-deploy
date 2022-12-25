# frozen_string_literal: true

# Routes for the cool books of this application
class ScheduleApplication
  path :schedule, '/schedule'
  path :group_all, '/schedule/by_groups'
  path :group do |name|
    "/schedule/by_groups/#{name}"
  end
  path :teacher_all, '/schedule/by_teachers'
  path :teacher do |name|
    "/schedule/by_teachers/#{name}"
  end

  hash_branch('schedule') do |r|
    append_view_subdir('schedule')

    r.is do
      view('navigation')
    end

    r.on 'by_groups' do
      r.is do
        view('groups_all')
      end

      r.on String do |group_name|
        @group_name = Rack::Utils.unescape(group_name)
        view('group_schedule')
      end
    end
  end
end
