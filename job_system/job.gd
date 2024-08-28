extends Object
class_name Job

## Class for storing a job data

## Properties of a job
var id: int
var name: String
var desc: String
var skills: PackedStringArray


## Constructor
func _init(id: int, name: String, desc: String, skills: String):
	self.id = id
	self.name = name
	self.desc = desc
	self.skills = split_skills(skills)


## Skills read from the CSV class file can be more than one and are separated by a semicolon.
## Hence the need to split them into individual skills and place them in an array.
func split_skills(skills):
	## Removes all occurences of double quotes
	skills = skills.replace("\"", "")
	
	return skills.split(";", false)
