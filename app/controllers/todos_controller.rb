class TodosController < ApplicationController
  before_action :set_todo, only: %i[ show update destroy ]

  # GET /todos
  def index
    @todos = Todo.all

    @todos = @todos.sort_by(&:currentIndex)

    render json: @todos
  end

  # GET /todos/1
  def show
    render json: @todo
  end

  # POST /todos
  def create
    @thisIndex = 0
    if Todo.all.length > 0
      @lastIndex = Todo.last.currentIndex
      @thisIndex = @lastIndex + 1
    end
    # @todo = Todo.new(todo_params)
    @todo = Todo.new({"currentIndex": @thisIndex, "content": todo_params["content"] })

    if @todo.save
      render json: @todo, status: :created, location: @todo
      # render json: @newParams
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1
  def update
    # * Get the param currentIndex and insert it in at that index 
    # * then put it in between the parenthese
    # * Loop and Update the entire table 
    currIndex = todo_params["currentIndex"]
    @todos = Todo.all
    flag = 0
    @todos = @todos.sort_by(&:currentIndex)

    @todos.each do |todo|
      if todo == @todo
        todo.update({"currentIndex": todo_params["currentIndex"]})
      else
        if flag == todo_params["currentIndex"]
          flag = flag + 1
        end
        todo.update({"currentIndex": flag })
        flag = flag + 1
      end
    end
    # @todos.each do |todo|
    #   if todo == @todo
    #     todo.update({"currentIndex": todo_params["currentIndex"]})
    #   else
    #     if flag == todo_params["currentIndex"]
    #       flag = flag + 1
    #     end
    #     todo.update({"currentIndex": flag})
    #   end
    #   flag = flag + 1
    # end    

    # if @todo.update(todo_params)
    # if @todo.update({"currentIndex": 1992})
    #   puts "HELLO"
    #   render json: @todo
    # else
    #   render json: @todo.errors, status: :unprocessable_entity
    # end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.require(:todo).permit(:content, :currentIndex, :currentInteger)
    end
end
