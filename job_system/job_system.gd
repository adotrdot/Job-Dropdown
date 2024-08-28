extends Object
class_name JobSystem

## Model for handling the job system


## An array containing all the jobs
var jobs: Array


## Constructor
func _init(class_path: String):
	jobs = CsvReader.read_csv_to_jobs(class_path, ";")


## Gets the name of a job
func get_jobname(id: int):
	return search_job(id, "name")
	
	
## Gets the description of a job
func get_jobdesc(id: int):
	return search_job(id, "desc")
	
	
## Gets the skills of a job
func get_jobskills(id: int):
	var skills: Array = search_job(id, "skills")
	
	## Creates a text that contains a list of skills
	var skills_text: String = ""
	for skill in skills:
		skills_text += "• " + skill + "\n"
			
	return skills_text

## Search for a property in a job
func search_job(id: int, key: String):
	for job in jobs:
		if job.id == id:
			match key:
				"name":
					return job.name
				"desc":
					return job.desc
				"skills":
					return job.skills
	
	assert(false, "Job id/key not found!")
