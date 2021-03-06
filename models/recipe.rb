

def db_connection
  begin

    connection = PG.connect(dbname: 'recipes')

    yield(connection)
    
  ensure
    connection.close
  end
end

class Recipe

	def self.all
		db_connection do |connect|
			recipes = connect.exec_params("SELECT recipes.name AS name, recipes.id AS id FROM recipes")
			
		end
		
	end

	def self.find(id)
		db_connection do |connect|
			info = connect.exec_params("SELECT recipes.name AS name, recipes.id AS id, 
				recipes.instructions AS instructions, recipes.description 
				AS description, ingredients.id AS ing_id, ingredients.name AS ingredients FROM recipes 
				JOIN ingredients ON recipes.id = ingredients.recipe_id WHERE recipes.id = #{id}")
			
		end
	end

end
