json.(medium, :id, :name, :description, :created_at, :updated_at)

projects ||= nil
unless projects.nil?
	json.projects(projects) do |project|
		json.partial!("api/projects/project", :project => project)
	end
end