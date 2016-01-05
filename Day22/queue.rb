#!/usr/bin/ruby

# https://rubymonk.com/learning/books/4-ruby-primer-ascent/chapters/33-advanced-arrays/lessons/86-stacks-and-queues
class Queue
  attr_reader :store

  def initialize
    @store = []
  end

  def dequeue
    @store.pop
  end

  def enqueue(element)
    @store.unshift(element)
    self
  end

  def size
    @store.size
  end

  def empty?
    @store.size.zero?
  end
end
