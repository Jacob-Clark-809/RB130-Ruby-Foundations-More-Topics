require_relative "todo.rb"
# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo)
    if todo?(todo)
      @todos << todo
    else
      raise TypeError.new("Can only add Todo objects")
    end
  end
  alias_method :<<, :add

  def item_at(ind)
    check_index(ind)
    @todos[ind]
  end

  def mark_done_at(ind)
    check_index(ind)
    @todos[ind].done!
  end

  def mark_undone_at(ind)
    check_index(ind)
    @todos[ind].undone!
  end

  def each
    @todos.each { |todo| yield(todo) }
    self
  end

  def select
    result = TodoList.new(title)
    each do |todo|
      result << todo if yield(todo)
    end

    result
  end

  def find_by_title(str)
    each do |todo|
      return todo if todo.title == str
    end
    nil
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(str)
    each do |todo|
      if todo.title == str
        todo.done!
        break
      end
    end
  end

  def mark_all_done
    each { |todo| todo.done! }
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end

  def done!
    @todos.each { |todo| todo.done! }
  end

  def done?
    @todos.all? { |todo| todo.done? }
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(ind)
    check_index(ind)
    @todos.delete_at(ind)
  end

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def to_a
    @todos.clone
  end

  def to_s
    str = "---#{title}---"
    @todos.each { |todo| str << "\n" + todo.to_s}
    str
  end

  private

  def todo?(obj)
    obj.class == Todo
  end

  def check_index(ind)
    raise IndexError.new unless ind >= 0 && ind < size
  end
end
