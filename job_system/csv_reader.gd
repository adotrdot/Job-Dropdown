extends Object
class_name CsvReader

## Provides methods for reading a CSV file
##
## This class currently can only read from a CSV file, without making any changes to it.

## Reads the given CSV file and returns it as a list of jobs
static func read_csv_to_jobs(path: String, delim: String = ",") -> Array:
	## Makes sure the given file exists
	assert(FileAccess.file_exists(path))
	
	## Opens the CSV file using FileAccess
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	
	## Makes sure the file has been successfully opened
	assert(file.is_open())
	
	## Initializes data and keys array
	var data = Array()
	var keys = PackedStringArray()
	
	## Stores CSV keys in the keys array
	if file.get_position() < file.get_length():
		keys = file.get_csv_line(delim)
	
	## Creates each lines of CSV file as a Dictionary with the key if they have them,
	## and adds it to data array
	while file.get_position() < file.get_length():
		var row = file.get_csv_line(delim)
		var new_data = Dictionary()
		for i in row.size():
			var key = keys[i]
			new_data[key] = row[i]
		var new_job = Job.new(int(new_data["ID"]), new_data["JOBNAME"], new_data["DESCRIPTION"], new_data["SKILLS"])
		data.append(new_job)
	
	## Closes the CSV file
	file.close()
	
	return data
