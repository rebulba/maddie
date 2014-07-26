Maddie.Routers.ProjectsRouter = Backbone.Router.extend({
	initialize: function(options) {
		this.$rootEl = options.$rootEL;
	},

	routes: {
		'': 'homeScreen',
		'home': 'homeScreen',
		'about': 'about',
		'inspiration': 'inspiration',
		'bros': 'bros',
		'work': 'mediaIndex',
		'media': 'mediaIndex',
		'media/:id': 'mediaShow',
		'projects': 'projectsIndex',
		'projects/:id': 'show'
	},
	
	homeScreen: function() {
		var homeView = new Maddie.Views.HomeScreenView({});
		
		this._swapView(homeView);
	},
	
	about: function(){
		var about = new Maddie.Views.About({
			templateName: "about"
		});
		this._swapView(about);
	},
	
	bros: function(){
		var about = new Maddie.Views.About({
			templateName: "bros"
		});
		this._swapView(about);
	},
	
	inspiration: function(){
		var about = new Maddie.Views.About({
			templateName: "inspiration"
		});
		this._swapView(about);
	},
	
  show: function (id) {
		var model = Maddie.Collections.projects.getOrFetch(id);
    var showView = new Maddie.Views.ProjectShow({
      model: model
    });

    this._swapView(showView);
  },
	
  projectsIndex: function () {
		Maddie.Collections.projects.fetch();
    var indexView = new Maddie.Views.ProjectsIndex({
			collection: Maddie.Collections.projects
    });
    this._swapView(indexView);
		
		//fix with composite view tutorial
		var newProjectView = new Maddie.Views.NewProject({
			model: new Maddie.Models.Project()
		})
		this.$rootEl.append(newProjectView.render().$el)
		
  },
	
	mediaIndex: function(){
		
		Maddie.Collections.media.fetch(); //must create that collection first...
		var mediaIndexView = new Maddie.Views.MediaIndex({
			collection: Maddie.Collections.media
		})
		
		this._swapView(mediaIndexView);
		
		//fix with composite view tutorial
		var newMediaView = new Maddie.Views.MediaNew({
			model: new Maddie.Models.Medium()
		})
		this.$rootEl.append(newMediaView.render().$el)
		
	},
	
	mediaShow: function(id){
		//GET OR FETCH FOR MEDIA HERE to pass in model below
		var model = Maddie.Collections.media.getOrFetch(id);
		var mediaShowView = new Maddie.Views.MediaShow({
			model: model
		});
		this._swapView(mediaShowView)
	},
	
  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }
	
	
});
