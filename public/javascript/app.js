$(document).ready(function() {

    var Todo = Backbone.Model.extend({
        initialize: function() {
            console.log('The model has been initialized');
            console.log(JSON.stringify(this));

            this.on('change:title', function() {
                console.log('The title has changed.');
            });

            this.on('invalid', function(model, error) {
                console.log(error)
            });
        },

        defaults: {
            title: '',
            completed: false
        },
    
        validate: function(attrs) {
            if (!attrs.title) {
                return "Don't forget a title!";
            }
        },
    });

    // var todo1 = new Todo({});

    // todo1.unset('title', {validate: true});
    // console.log(JSON.stringify(todo1));
    //

    _.templateSettings = {
      interpolate : /\{\{(.+?)\}\}/g
    };

    var TodoView = Backbone.View.extend({

        tagName: 'li',

        todoTpl: _.template("An example template"),

        events: {
            'dblclick label': 'edit',
            'keypress .edit': 'updateOnEnter',
            'blur .edit': 'close'
        },

        render: function() {
            this.$el.html(this.todoTpl( this.model.toJSON() ));
            this.input = this.$('.edit');
            return this;
        },

        close: function() {
        },

        updateOnEnter: function(e) {
        },

    });

    var todoView = new TodoView();

    //console.log(todoView.el);
    
    var TodosCollection = Backbone.Collection.extend({
        model: Todo,

        initialize: function() {
            this.on("add", function(todo) {
                console.log("I should " + todo.get('title'));
            });

            this.on('change', function(todo) {
                console.log("Actually, I should " + todo.get('title'));
            });
        },

    });

    todo = new Todo({title: 'walk dog'});
    todoId = todo.cid;

    todos = new TodosCollection();

    todos.add(todo);
    todo.set('title', 'watch TV');

});

