export function initialize(_container, application) {
  // Injects notifier service with the router:
  application.inject('service:notifier', 'router', 'router:main');
}

export default {
  name: 'notifier',
  initialize: initialize
};
