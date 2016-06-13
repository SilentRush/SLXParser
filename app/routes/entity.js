import Ember from 'ember';

export default Ember.Route.extend({
  model(){
    return Ember.$.getJSON('assets/output.json');
  },
  quickforms(){
    console.log(Ember.$.getJSON('assets/output.json').quickforms);
  }
});
