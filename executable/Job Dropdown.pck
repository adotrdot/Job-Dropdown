GDPC                �                                                                      $   P   res://.godot/exported/133200997/export-234ad4d8d43f2f55834435b9887da50b-main.res4      �      :�E�/0u�;�0q    P   res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn�?      �      A&1ݣ;�����klD    ,   res://.godot/global_script_class_cache.cfg  @M      �      7�n�Òu&]����Y�    T   res://.godot/imported/arrow_basic_s_small.png-a980ea00f6a3466aaaa349e923df3305.ctex P      $      �B�B|�1�3	D/�f�    P   res://.godot/imported/bg_square_line.png-e0e8fd9885538fcbffb4f4489d50522e.ctex  P            f�T��>u��z��S�    X   res://.godot/imported/button_rectangle_border.png-8618d292179c48de7a0491db11deb619.ctex 0            i��l���@H�L�/Ag    `   res://.godot/imported/button_rectangle_depth_border.png-e09bc4a53b81dd95272da30bb20fb91a.ctex          H      �'t2ۧIo)����0�4    \   res://.godot/imported/button_rectangle_depth_gloss.png-a9b7652677f99ea4754b379858d30c52.ctexP      .      b�Ђ3��4�+��Y�    `   res://.godot/imported/button_rectangle_depth_gradient.png-48e1ee94d40ed0b795e9b41d58de5deb.ctex `      �      �x����f_�׭��    \   res://.godot/imported/button_rectangle_depth_line.png-1acbc7b92b3d5c7781156ee2da42c276.ctex        @      v��Z�5ZYT$��z��    X   res://.godot/imported/button_rectangle_line.png-ef5ef0c7d3c06698ae18388acdc444d9.ctex   @            ,�B�8�жI\.|��    T   res://.godot/imported/button_round_border.png-3493195ae3c79a0f1cbbd8389abe90d3.ctex 0            痜3m?[�,�:-X    T   res://.godot/imported/button_round_flat.png-71e127b93373fa7b32558cbd199ed212.ctex         �       )��<�Ut�2�y����    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex�!            ：Qt�E�cO���       res://.godot/uid_cache.bin  �R      n      3���J%a�?�s�b4�       res://icon.svg  �N      �      k����X3Y���f       res://icon.svg.import   �.      �       J���gxƣ�p�'�Z}        res://job_system/csv_reader.gd          �      �$�
�P�0�Mi��       res://job_system/job.gd        �      �P�9:V���G����        res://job_system/job_system.gd  �      �      ����M�z������       res://main.gd   �/      �      ���H3BN�x�U�       res://main.tres.remap   `L      a       ���(���R+6���       res://main.tscn.remap   �L      a       �J�Sw� ������       res://option_button.gd  �K      �       cd�Qz������`��       res://project.binary U      �      �^�P��f����܆Q��    0   res://resource/arrow_basic_s_small.png.import   �      �       A�R�@������     (   res://resource/bg_square_line.png.import`      �       $�9���bRQ�`�5��    4   res://resource/button_rectangle_border.png.import   @      �       .���lR�	T��    8   res://resource/button_rectangle_depth_border.png.import p      �       }8Zć8A��QzO    8   res://resource/button_rectangle_depth_gloss.png.import  �      �       Yׇ�>��&t.�Kd2    <   res://resource/button_rectangle_depth_gradient.png.import   @      �       ���_1�}l'��'ĝ
    8   res://resource/button_rectangle_depth_line.png.import   `      �       ڳ�'4,W�1��վ�    0   res://resource/button_rectangle_line.png.import P      �       ���f����,;:=RЉ?    0   res://resource/button_round_border.png.import   @      �       Ƙ�zUf�
�[ ��KL    ,   res://resource/button_round_flat.png.import       �       ^�ȢB�(����煉[       res://resource/class.csv�      �      bc	�!Ȥab
@=0��                extends Object
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
               extends Object
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
     extends Object
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
      GST2            ����                        �   RIFF�   WEBPVP8L�   /�נ�m$g��Sm�)�KCq)���\��Qܶm�v�]�~s"h#5E	�q4	H�)  �{�#��V�A����p��'E�'F����7��u@Y�A�x�.0`�H���g�9�o�i�$D��`�6m7��;�u>��&����HQa-zi�����TZ*�O��F��=�^ח�/�������1�(�.����P4�1��p[ͥ D�}?�����o            [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://5i1suiogfl5i"
path="res://.godot/imported/arrow_basic_s_small.png-a980ea00f6a3466aaaa349e923df3305.ctex"
metadata={
"vram_texture": false
}
  GST2   @   @      ����               @ @        �   RIFF�   WEBPVP8L�   /?����m#'��a�㟆�����?�ò����?�cq��D������������17ݧz���,Uu�.j�����l.p$IR�Hb)v��k�[gGD�'��3{G��yJ��Y7��1��ɰф#̮;Hޗ�� �YH�`�~��<�wQ�hx�T.�A2��8u"�2�����tڮ           [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dn7l4i3im0x14"
path="res://.godot/imported/bg_square_line.png-e0e8fd9885538fcbffb4f4489d50522e.ctex"
metadata={
"vram_texture": false
}
      GST2   �   @      ����               � @        �   RIFF�   WEBPVP8L�   /������$e׿ē��`CA�FN�?�c�蓼����b��l#��������?5w�wΙ�v�sN��5Ԝ�� �C�C	��B��m#G�Ρ����]�ճy#�?Z����NU]�~��7B���Y���"��� �H��=��j�����{Ga�Z�~�`ı�ĠMd!>c �S�_Uu7��V     [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cdfamdwp3mw65"
path="res://.godot/imported/button_rectangle_border.png-8618d292179c48de7a0491db11deb619.ctex"
metadata={
"vram_texture": false
}
             GST2   �   @      ����               � @          RIFF  WEBPVP8L�   /����m#'���=��CCA�FN��#�=�_A�FN��C|�!�m'w� �LR)�������ݧ{Yy�>5c�p���[>+xЀ�������H�^E���$C<����� l��%�����$�J�_������d�͒��O@��eQP�(�4�JJ_f�xɽO�*g�#�$��P��$	�n~!!y�UP��������B�GC���e�2��1ہ�t��a�(}7�s�����z��_�z�xjwn�t,�-�4        [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://c80qo4q2bnjqt"
path="res://.godot/imported/button_rectangle_depth_border.png-e09bc4a53b81dd95272da30bb20fb91a.ctex"
metadata={
"vram_texture": false
}
       GST2   �   @      ����               � @        �   RIFF�   WEBPVP8L�   /�����m#'��>��CCA�FNⱸ�SA�F����|{#�m'w� �LR)�������d�Ʊ�2��{��V�ɑ�@�>(�7T��;z��U��ki�CԠ��l4��T��H��D�8����?ۜ_D�' M�"ϑ<ϋ*I�鋴��w&��c(3">"��0���{d���E�ƙ��g��!2�#�B�B���i��Z����s���ۆC�c�}�m��   [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://deu5a32xntbld"
path="res://.godot/imported/button_rectangle_depth_gloss.png-a9b7652677f99ea4754b379858d30c52.ctex"
metadata={
"vram_texture": false
}
        GST2   �   @      ����               � @        �  RIFF�  WEBPVP8L�  /��O�(�$E��=���s�pI������Z��H�)���O�#��!�m'w� �LR)�����Z��P�E �@Dȷ(��X�� %�C�ͺ�j{��ˡܗ�?�&�|R�0�����q:?�e�����cФ$1�f�� �� �#I��Zf�^fn�f����Vq��SD�'�Tԫ���W*�zQ*U��Z�Iy��I�K��� >SYJ�%���Y����%�n�[��sX��ְ�u�n����m�n�������}�� �;��c���;��ΰ�s�.��s���.�����k������{���{��g���{��ް�w��������$D_У���T�gjv��[*u�-�o���v�[�����gsz���t��M��^     [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cnqtshghpegnf"
path="res://.godot/imported/button_rectangle_depth_gradient.png-48e1ee94d40ed0b795e9b41d58de5deb.ctex"
metadata={
"vram_texture": false
}
     GST2   �   @      ����               � @          RIFF   WEBPVP8L�   /����m#'������m#'������m����v����B�Fj�S8p�w@���hg��t͋�����������!{����O������r}�r|p�<�6J�H�l%z_�Ҹ�����r�Y��	�Һ,
P^e�fY	�ˬb��I�*��=r@�XG�5"  �Ѯ~�s��9y���������G-�5#M� ���y��0u���֩oxk�i�'����k<�;�e97޶sY [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://6xi6er7m8u11"
path="res://.godot/imported/button_rectangle_depth_line.png-1acbc7b92b3d5c7781156ee2da42c276.ctex"
metadata={
"vram_texture": false
}
          GST2   �   @      ����               � @        �   RIFF�   WEBPVP8L�   /�����m#'���ؿ�������Gc�~m$)��_�Y�g~�d�F�j�#h ��oV�K�\sug�s�l3��^�*��?�`�����-��$���a���ת�n�RD�'�ջƠ�c�[[[�~�Co ��<��gn���(y�0$	Dف7H�����ׄ�N���a��>s^2��[�_���u�5           [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://u0alotk066m7"
path="res://.godot/imported/button_rectangle_line.png-ef5ef0c7d3c06698ae18388acdc444d9.ctex"
metadata={
"vram_texture": false
}
                GST2            ����                        �   RIFF�   WEBPVP8L�   /�����$��[�',�P�6���K�/Á¶������3	��-D�sK���}*��#�O.1&��6@18� ��cL��0l��Q����������"���mƚ�� I���H �كM�[��#�W�>�q^1z�u�8_�o�,oɔ-��r���n�_��
�����"Y�S���O$��`@�\�S�ZH  [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://l0fbkrcjcj2a"
path="res://.godot/imported/button_round_border.png-3493195ae3c79a0f1cbbd8389abe90d3.ctex"
metadata={
"vram_texture": false
}
  GST2            ����                        �   RIFF�   WEBPVP8L�   /����m&���C�6
ڶa�@�M
ڶa���: 뙀����bnb�����|����m�E [�-�H������I��*���	�$��~�$�T4$��"7���~��>���ѭZ�v��t�|ڙ��Β��vbY
ԯ���`o�%���Ր�)��9=�D           [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://uk0a8krk50w0"
path="res://.godot/imported/button_round_flat.png-71e127b93373fa7b32558cbd199ed212.ctex"
metadata={
"vram_texture": false
}
    ﻿ID;JOBNAME;DESCRIPTION;SKILLS
1;Warrior;A strength focused job. Warrior uses a two handed sword.;"Slash;Break Shield;Parry;"
2;Mage;An intelligence focused job. Mage uses magic to damage enemies or support allies.;"Fire;Ice;Cure;"
3;Thief;An agility focused job. Thief uses a dagger.;"Agility Boost;Stealth;Steal;"
4;Dark Mage;An intelligence focused job, like Mage, but has more damage-dealing magic.;"Typhoon;Earthquake;Lightning Blast"
 GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�m�m۬�}�p,��5xi�d�M���)3��$�V������3���$G�$2#�Z��v{Z�lێ=W�~� �����d�vF���h���ڋ��F����1��ڶ�i�엵���bVff3/���Vff���Ҿ%���qd���m�J�}����t�"<�,���`B �m���]ILb�����Cp�F�D�=���c*��XA6���$
2#�E.@$���A.T�p )��#L��;Ev9	Б )��D)�f(qA�r�3A�,#ѐA6��npy:<ƨ�Ӱ����dK���|��m�v�N�>��n�e�(�	>����ٍ!x��y�:��9��4�C���#�Ka���9�i]9m��h�{Bb�k@�t��:s����¼@>&�r� ��w�GA����ը>�l�;��:�
�wT���]�i]zݥ~@o��>l�|�2�Ż}�:�S�;5�-�¸ߥW�vi�OA�x��Wwk�f��{�+�h�i�
4�˰^91��z�8�(��yޔ7֛�;0����^en2�2i�s�)3�E�f��Lt�YZ���f-�[u2}��^q����P��r��v��
�Dd��ݷ@��&���F2�%�XZ!�5�.s�:�!�Њ�Ǝ��(��e!m��E$IQ�=VX'�E1oܪì�v��47�Fы�K챂D�Z�#[1-�7�Js��!�W.3׹p���R�R�Ctb������y��lT ��Z�4�729f�Ј)w��T0Ĕ�ix�\�b�9�<%�#Ɩs�Z�O�mjX �qZ0W����E�Y�ڨD!�$G�v����BJ�f|pq8��5�g�o��9�l�?���Q˝+U�	>�7�K��z�t����n�H�+��FbQ9���3g-UCv���-�n�*���E��A�҂
�Dʶ� ��WA�d�j��+�5�Ȓ���"���n�U��^�����$G��WX+\^�"�h.���M�3�e.
����MX�K,�Jfѕ*N�^�o2��:ՙ�#o�e.
��p�"<W22ENd�4B�V4x0=حZ�y����\^�J��dg��_4�oW�d�ĭ:Q��7c�ڡ��
A>��E�q�e-��2�=Ϲkh���*���jh�?4�QK��y@'�����zu;<-��|�����Y٠m|�+ۡII+^���L5j+�QK]����I �y��[�����(}�*>+���$��A3�EPg�K{��_;�v�K@���U��� gO��g��F� ���gW� �#J$��U~��-��u���������N�@���2@1��Vs���Ŷ`����Dd$R�":$ x��@�t���+D�}� \F�|��h��>�B�����B#�*6��  ��:���< ���=�P!���G@0��a��N�D�'hX�׀ "5#�l"j߸��n������w@ K�@A3�c s`\���J2�@#�_ 8�����I1�&��EN � 3T�����MEp9N�@�B���?ϓb�C��� � ��+�����N-s�M�  ��k���yA 7 �%@��&��c��� �4�{� � �����"(�ԗ�� �t�!"��TJN�2�O~� fB�R3?�������`��@�f!zD��%|��Z��ʈX��Ǐ�^�b��#5� }ى`�u�S6�F�"'U�JB/!5�>ԫ�������/��;	��O�!z����@�/�'�F�D"#��h�a �׆\-������ Xf  @ �q�`��鎊��M��T�� ���0���}�x^�����.�s�l�>�.�O��J�d/F�ě|+^�3�BS����>2S����L�2ޣm�=�Έ���[��6>���TъÞ.<m�3^iжC���D5�抺�����wO"F�Qv�ږ�Po͕ʾ��"��B��כS�p�
��E1e�������*c�������v���%'ž��&=�Y�ް>1�/E������}�_��#��|������ФT7׉����u������>����0����緗?47�j�b^�7�ě�5�7�����|t�H�Ե�1#�~��>�̮�|/y�,ol�|o.��QJ rmϘO���:��n�ϯ�1�Z��ը�u9�A������Yg��a�\���x���l���(����L��a��q��%`�O6~1�9���d�O{�Vd��	��r\�՜Yd$�,�P'�~�|Z!�v{�N�`���T����3?DwD��X3l �����*����7l�h����	;�ߚ�;h���i�0�6	>��-�/�&}% %��8���=+��N�1�Ye��宠p�kb_����$P�i�5�]��:��Wb�����������ě|��[3l����`��# -���KQ�W�O��eǛ�"�7�Ƭ�љ�WZ�:|���є9�Y5�m7�����o������F^ߋ������������������Р��Ze�>�������������?H^����&=����~�?ڭ�>���Np�3��~���J�5jk�5!ˀ�"�aM��Z%�-,�QU⃳����m����:�#��������<�o�����ۇ���ˇ/�u�S9��������ٲG}��?~<�]��?>��u��9��_7=}�����~����jN���2�%>�K�C�T���"������Ģ~$�Cc�J�I�s�? wڻU���ə��KJ7����+U%��$x�6
�$0�T����E45������G���U7�3��Z��󴘶�L�������^	dW{q����d�lQ-��u.�:{�������Q��_'�X*�e�:�7��.1�#���(� �k����E�Q��=�	�:e[����u��	�*�PF%*"+B��QKc˪�:Y��ـĘ��ʴ�b�1�������\w����n���l镲��l��i#����!WĶ��L}rեm|�{�\�<mۇ�B�HQ���m�����x�a�j9.�cRD�@��fi9O�.e�@�+�4�<�������v4�[���#bD�j��W����֢4�[>.�c�1-�R�����N�v��[�O�>��v�e�66$����P
�HQ��9���r�	5FO� �<���1f����kH���e�;����ˆB�1C���j@��qdK|
����4ŧ�f�Q��+�     [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://1l3lqldkls7m"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 extends Control

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
     RSRC                    Theme            ��������                                            9      resource_local_to_scene    resource_name    content_margin_left    content_margin_top    content_margin_right    content_margin_bottom    texture    texture_margin_left    texture_margin_top    texture_margin_right    texture_margin_bottom    expand_margin_left    expand_margin_top    expand_margin_right    expand_margin_bottom    axis_stretch_horizontal    axis_stretch_vertical    region_rect    modulate_color    draw_center    script 	   bg_color    skew    border_width_left    border_width_top    border_width_right    border_width_bottom    border_color    border_blend    corner_radius_top_left    corner_radius_top_right    corner_radius_bottom_right    corner_radius_bottom_left    corner_detail    shadow_color    shadow_size    shadow_offset    anti_aliasing    anti_aliasing_size    default_base_scale    default_font    default_font_size    Label/colors/font_color    OptionButton/colors/font_color %   OptionButton/colors/font_focus_color %   OptionButton/colors/font_hover_color $   OptionButton/constants/arrow_margin    OptionButton/icons/arrow    OptionButton/styles/hover    OptionButton/styles/normal    OptionButton/styles/pressed    PopupMenu/colors/font_color "   PopupMenu/colors/font_hover_color    PopupMenu/icons/radio_checked     PopupMenu/icons/radio_unchecked    PopupMenu/styles/hover    PopupMenu/styles/panel    
   Texture2D '   res://resource/arrow_basic_s_small.png x]n�9y
   Texture2D 0   res://resource/button_rectangle_depth_gloss.png ����Ei�g
   Texture2D 3   res://resource/button_rectangle_depth_gradient.png �c�'V�_O
   Texture2D 1   res://resource/button_rectangle_depth_border.png �P"��Xc
   Texture2D '   res://resource/button_round_border.png Z��/�ho
   Texture2D %   res://resource/button_round_flat.png ��<�+��
   Texture2D )   res://resource/button_rectangle_line.png �୴�2      local://StyleBoxTexture_iljtr �         local://StyleBoxTexture_8up2m 	         local://StyleBoxTexture_6xjol z	         local://StyleBoxFlat_p1m3h �	         local://StyleBoxTexture_0oxwk ?
         local://Theme_7v1qr �
         StyleBoxTexture                        �A         A	        �A
        pA         StyleBoxTexture                        �A         A	        �A
        pA         StyleBoxTexture                        �A         A	        �A
        pA         StyleBoxFlat                      ��?                                              StyleBoxTexture                         A         A	         A
         A         Theme    *                    �?+                    �?,                    �?-                    �?.         /             0             1            2            3                    �?4                    �?5            6            7            8                  RSRC           RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://main.gd ��������
   Texture2D "   res://resource/bg_square_line.png u�����p   Theme    res://main.tres $A���ܯ   Script    res://option_button.gd ��������      local://PackedScene_q8a4f �         PackedScene          	         names "   -      Main    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control    BG    anchor_left    anchor_top    offset_left    offset_top    offset_right    offset_bottom    texture    patch_margin_left    patch_margin_top    patch_margin_right    patch_margin_bottom    NinePatchRect    VBoxContainer    Title    size_flags_horizontal    size_flags_vertical    theme    text    Label    OptionButton    mouse_default_cursor_shape    text_direction    HBoxContainer    custom_minimum_size $   theme_override_constants/separation    JobNameTitle    JobName    JobDescTitle    JobDesc    autowrap_mode    VBoxContainer2    JobSkillsTitle 
   JobSkills     _on_option_button_item_selected    item_selected    	   variants    )                    �?                         ����      ?   ���>    @��     /�    @�C     /C                  =
W>     ��     ��     �B     �A                     SELECT YOUR JOB:          
     �C       33�>   ��?     ��     ��     �B     �A   2                Job Name :       JobName       Description : 
     �C          JobDesc    	   Skills : 
     C       
   JobSkills       node_count             nodes       ��������       ����                                                             	   ����               
                           	      
                                                                           ����               
                                                                             ����                                                  ����                                                     ����   !                  
                                                      "                       ����                                     #   ����                  !                 $   ����                  "                 %   ����                  #                 &   ����   !   $                  %   '                     (   ����                       )   ����                  &                 *   ����   !   '                         (   '                 conn_count             conns               ,   +                    node_paths              editable_instances              version             RSRC extends OptionButton


## Set up items, accepts an array of jobs as parameter
func setup(jobs: Array):
	for job in jobs:
		self.add_item(job.name, job.id)
		
  [remap]

path="res://.godot/exported/133200997/export-234ad4d8d43f2f55834435b9887da50b-main.res"
               [remap]

path="res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn"
               list=Array[Dictionary]([{
"base": &"Object",
"class": &"CsvReader",
"icon": "",
"language": &"GDScript",
"path": "res://job_system/csv_reader.gd"
}, {
"base": &"Object",
"class": &"Job",
"icon": "",
"language": &"GDScript",
"path": "res://job_system/job.gd"
}, {
"base": &"Object",
"class": &"JobSystem",
"icon": "",
"language": &"GDScript",
"path": "res://job_system/job_system.gd"
}])
             <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 814 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H446l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z" fill="#478cbf"/><path d="M483 600c0 34 58 34 58 0v-86c0-34-58-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
              x]n�9y&   res://resource/arrow_basic_s_small.pngu�����p!   res://resource/bg_square_line.png��u�r^ME*   res://resource/button_rectangle_border.png�P"��Xc0   res://resource/button_rectangle_depth_border.png����Ei�g/   res://resource/button_rectangle_depth_gloss.png�c�'V�_O2   res://resource/button_rectangle_depth_gradient.pngf^����.   res://resource/button_rectangle_depth_line.png�୴�2(   res://resource/button_rectangle_line.pngZ��/�ho&   res://resource/button_round_border.png��<�+��$   res://resource/button_round_flat.png,G�'�+�   res://icon.svg$A���ܯ   res://main.tresbl26��s   res://main.tscn  ECFG      application/config/name         Job Dropdown   application/run/main_scene         res://main.tscn    application/config/features(   "         4.2    GL Compatibility       application/config/icon         res://icon.svg  #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility            