import Ember from 'ember';

export default Ember.Controller.extend({
  actions:{
    toggleDiv: function(){
      console.log(Ember.$(this));
      Ember.$(this).find(".collapseDiv").toggle();
    }
  }
});
