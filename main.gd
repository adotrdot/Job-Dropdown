extends Control

## Main node
## This will communicate with the JobSystem class to get the jobs data


## This stores the JobSystem object
var job_system: JobSystem

## This stores the path to the CSV file containing all the jobs
var csv_class_path: String = "res://resource/class.csv"

## Gets the OptionButton node
@onready var option_button: OptionButton = $VBoxContainer/OptionButton
@onready var job_name: Label = $HBoxContainer/VBoxContainer/JobName
@onready var job_desc: Label = $HBoxContainer/VBoxContainer/JobDesc
@onready var job_skills: Label = $HBoxContainer/VBoxContainer2/JobSkills


func _ready():
	## Initialize job system
	job_system = JobSystem.new(csv_class_path)
	
	## Initialize dropdown and its items
	option_button.setup(job_system.jobs)
	
	## Display initial job (which has id 1)
	display_job_data(1)


## Sets job's data
func display_job_data(id: int):
	job_name.set_text(job_system.get_jobname(id))
	job_desc.set_text(job_system.get_jobdesc(id))
	job_skills.set_text(job_system.get_jobskills(id))


func _on_option_button_item_selected(index: int):
	var selected_id: int = option_button.get_selected_id()
	display_job_data(selected_id)
