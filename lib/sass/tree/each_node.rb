require 'sass/tree/node'

module Sass::Tree
  # A dynamic node representing a Sass `@each` loop.
  #
  # @see Sass::Tree
  class EachNode < Node
    # The name of the loop variable.
    # @return [String]
    attr_reader :var

    # The parse tree for the list.
    # @param [Script::Node]
    attr_reader :list

    # @param var [String] The name of the loop variable
    # @param list [Script::Node] The parse tree for the list
    def initialize(var, list)
      @var = var
      @list = list
      super()
    end

    protected

    # @see Node#to_src
    def to_src(tabs, opts, fmt)
      "#{'  ' * tabs}@each $#{dasherize(@var, opts)} in #{@list.to_sass(opts)}" +
        children_to_src(tabs, opts, fmt)
    end

    # Returns an error message if the given child node is invalid,
    # and false otherwise.
    #
    # {ExtendNode}s are valid within {EachNode}s.
    #
    # @param child [Tree::Node] A potential child node.
    # @return [Boolean, String] Whether or not the child node is valid,
    #   as well as the error message to display if it is invalid
    def invalid_child?(child)
      super unless child.is_a?(ExtendNode)
    end
  end
end
