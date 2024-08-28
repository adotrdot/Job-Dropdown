extends OptionButton


## Set up items, accepts an array of jobs as parameter
func setup(jobs: Array):
	for job in jobs:
		self.add_item(job.name, job.id)
		
