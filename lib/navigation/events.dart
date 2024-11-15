enum NavigationTab { home, profile }

abstract class NavigationEvent {}

class NavigationTabChanged extends NavigationEvent {
  final NavigationTab tab;
  NavigationTabChanged(this.tab);
}
