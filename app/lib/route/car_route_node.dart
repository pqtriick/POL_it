class CarRouteNode {

  NodeType type;

  CarRouteNode(this.type);

}

enum NodeType {
  movement,
  delay
}