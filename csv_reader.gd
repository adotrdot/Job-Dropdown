extends Object
class_name CsvReader

## Provides methods for reading a CSV file
##
## This class currently can only read from a CSV file, without making any changes to it.

## Reads the given CSV file and returns it as a Dictionary
static func read_csv_as_dict(path: String, has_keys: bool = false, delim: String = ",") -> Array:
	## Makes sure the given file exists
	assert(FileAccess.file_exists(path))
	
	## Opens the CSV file using FileAccess
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	
	## Makes sure the file has been successfully opened
	assert(file.is_open())
	
	## Initializes data and keys array
	var data = Array()
	var keys = PackedStringArray()
	
	## If the given CSV file has keys, stores those in the keys array
	if has_keys:
		if file.get_position() < file.get_length():
			keys = file.get_csv_line(delim)
	
	## Creates each lines of CSV file as a Dictionary with the key if they have them,
	## and adds it to data array
	while file.get_position() < file.get_length():
		var row = file.get_csv_line(delim)
		var new_data = Dictionary()
		for i in row.size():
			var key = keys[i] if has_keys else i
			new_data[key] = row[i]
		data.append(new_data)
	
	## Closes the CSV file
	file.close()
	
	return data
