require 'shoes'

Shoes.app(title: "Complete Me", width: 600, height: 400) do
  stack margin: 10 do

    stack margin: 10 do
      # background gainsboro
      subtitle "Autocomplete"
      tagline "for those of us who can't remember how words end"
    end

    stack(margin: 15){
      button "Search for completions"
      button "Load from file"
      button "Weight words against searches"
    }

  end
end
