Maddie.Views.NewProject = Backbone.View.extend({
	
	initialize: function(options){
		this.model = options.model;
	},
	
	template: JST["projects/new"],
	
	events: {
		"submit form": "submit"
	},
	
	render: function(){
		var content = this.template({
			project: this.model
		});
		this.$el.html(content);
		return this;
	},
	
	submit: function(){
		event.preventDefault();
		
		
		// newProject.set("title", $("#title").val());
		// newProject.set("description", $("#description").val());
		
		var params = $(event.currentTarget).children().serializeJSON()
		var newProject = new Maddie.Models.Project(params);
		
		
		newProject.save({}, {
			success: function() {
				Maddie.Collections.projects.add(newProject)
			}
		})
	}
	
})