<tasks>
  <task each={data.tasks}/>
  <script>
    this.getMeteorData = function() {
      var tasks;
       if (Session.get("hideCompleted")) {
        // If hide completed is checked, filter tasks
        tasks = Tasks.find({checked: {$ne: true}}, {sort: {createdAt: -1}}).fetch();
      } else {
        // Otherwise, return all of the tasks
        tasks = Tasks.find({}, {sort: {createdAt: -1}}).fetch();
      }
      return {
        tasks: tasks
      }
    };
    this.mixin('RiotMeteorData');
    setChecked(e){
      var item = e.item;
      Meteor.call("setChecked", item._id, e.target.checked);
    }
    setPrivate(e){
      var item = e.item;
      Meteor.call("setPrivate", item._id, ! item.private);
    }
    deleteTask(e){
      var item = e.item;
      Meteor.call("deleteTask", item._id);
    }
  </script>
</tasks>



<task>
 <li class="{ checked : checked } { private: private }">
    <button class="delete" onclick={ parent.deleteTask }>&times;</button>

    <input type="checkbox" checked="{checked}" onclick={ parent.setChecked } class="toggle-checked" />

      <button if={ owner === Meteor.userId() } onclick={ parent.setPrivate } class="toggle-private">
        { private? "Private" : "Public" }
      </button>

    <span class="text"><strong>{username}</strong> - {text}</span>
  </li>
</task>
