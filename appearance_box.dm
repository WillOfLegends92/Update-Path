mob
	var/tmp
		appearance_box/appearance_box

		hair_scroll_position = 1
		hair_color_position = "#000000"
		list/hair_list = list("Bald","LA Hair","Messy Ponytail","Short Spiky Ponytail","Noble","Rough","Sideswept","Thug","Twintails","Braid","Rihanna","Lightning","Skrillex","R-Skrilly","Girl Next Door","Ski-jump","Bowl Cut","Untidy","Unbrushed","Buns","Back Pigtail","Short-cut","Short Spikey","Slanted Top","Gelled Top","Topknot","Bangs 2","Bangs","Afro","Messy","Messy Afro","Mohawk","Buzzcut","Ski-jump","Orderly","Double Topknot Male","Long Ponytail","Loose","Loose Ponytail","Messy Gel","Double Topknot Female","Long","Balding","Ponytail","Spiked Back","Uncombed","Spikey","Topknot","Untidy","Trimmed Long","Wild Long","Bed Head","Side Spikey Pig Tail","Two Spikey Pig Tail","Tomboy","Cloud Strife","Braided","Buns","Ditsy","Dreads", "Long Emo", "Lolly", "Long Flowing", "Long Tail", "Nanoa", "Oriental", "Parted", "Pigtails", "Pretty Long", "Short Parted", "New Spikey", "Deidara", "Dreadlocks", "Emo2", "Front Tails" , "Front Tails Longs", "Gohan", "Haku", "Jiraiya", "Madara", "Messy2", "Minato", "Mizukage", "Orochimaru", "Karn", "RichKid", "Ryuzaki", "Seven1", "Seven2", "Sleek", "Super", "Thick", "Tousen", "Tsunade", "Umir", "Valnium", "Valnium2", "Yahair")

	var/list/hair_stack
	var/list/saved_overlays
	var/saved_icon
	var/saved_invisibility

	proc
		create_appearance()

			var/mob/M = src
			if(M.makingClone) M = M.clones[M.clones.len]
			
			// Save current state
			M.saved_overlays = M.overlays.Copy()
			M.saved_icon = M.icon
			M.saved_invisibility = M.invisibility
			
			// Clear hair and hide character
			for(var/o in M.hair_stack)
				M.overlays -= o
			del(M.hair_stack)
			M.hair_stack = list()
			
			// Hide the character while menu is open
			M.invisibility = 101
			
			if(!appearance_box)
				appearance_box = new(src)
				appearance_box.update_hair(src)
			appearance_box.show()
			appearance_box.center(src)
			
		create_appearance2()

			var/mob/M = src
			if(M.makingClone) M = M.clones[M.clones.len]
			
			// Save current state
			M.saved_overlays = M.overlays.Copy()
			M.saved_icon = M.icon
			M.saved_invisibility = M.invisibility
			
			// Clear hair and hide character
			for(var/o in M.hair_stack)
				M.overlays -= o
			del(M.hair_stack)
			M.hair_stack = list()
			
			// Hide the character while menu is open
			M.invisibility = 101
			
			if(!appearance_box)
				appearance_box = new(src)
				appearance_box.update_hair(src)
			appearance_box.show()
			appearance_box.center(src)

		update_base(id)
			Tan = 0
			Pale = 0
			Dark = 0
			White = 0
			if(Female)
				Gender = "female"
				switch(id)
					if(2)
						icon = 'Base_FemalePale.dmi'
						Pale = 1
					if(3)
						icon = 'Base_FemalePale.dmi'
						Pale = 1
					if(4)
						icon = 'Base_FemalePale.dmi'
						Pale = 1
					if(5)
						icon = 'Base_FemaleTan.dmi'
						Tan = 1
					if(6)
						icon = 'Base_FemaleBlack.dmi'
						Dark = 1
					if(1)
						icon = 'Base_FemaleWhite.dmi'
						White = 1
			else
				Gender = "male"
				switch(id)
					if(2)
						icon = 'Base_Pale.dmi'
						Pale = 1
					if(3)
						icon = 'Base_Pale.dmi'
						Pale = 1
					if(4)
						icon = 'Base_Pale.dmi'
						Pale = 1
					if(5)
						icon = 'Base_Tan.dmi'
						Tan = 1
					if(6)
						icon = 'Base_Black.dmi'
						Dark = 1
					if(1)
						icon = 'Base_White.dmi'
						White = 1
			Oicon = icon



appearance_box
	parent_type = /HudGroup

	icon = 'Appearance.dmi'
	layer = 100000000

	var/appearance_display/appearance_display
	var/appearance_back_button/appearance_back_button
	var/appearance_forwards_button/appearance_forwards_button
	var/appearance_name/name_info

	var/color_boxes/color_boxes
	var/add_button/add_button
	var/del_button/del_button
	var/rgb_button/rgb_button

	var/skin_color_box/skin_color_box
	var/clone = 0
	var/gender_indicator/gender_indicator
	var/gender_button/gender_button
	var/confirm_button/confirm_button

	New(mob/m)
		..()

		for(var/x = 0 to 7)
			for(var/y = 0 to 8)
				var/px = x * 32
				var/py = y * 32
				add(px, py, icon_state = "[x],[y]")
		appearance_display = new(src, 'Characterbox.dmi', "card1")
		appearance_display.pos(100, 175)
		appearance_display.icon = 'Base_Pale.dmi'
		add(appearance_display)

		appearance_back_button = new(src)
		appearance_back_button.pos(11, 133)
		appearance_back_button.set_button_style("◄", "Left")
		add(appearance_back_button)

		appearance_forwards_button = new(src)
		appearance_forwards_button.pos(196, 133)
		appearance_forwards_button.set_button_style("►", "Right")
		add(appearance_forwards_button)

		name_info = new(src, 'Blank.dmi', "blank")
		name_info.layer = 101
		name_info.pos(101, 118)
		add(name_info)

		color_boxes = new(m)
		add(color_boxes)

		add_button = new(src)
		add_button.pos(183, 104)
		add_button.set_button_style("+", "Add Hair")
		add(add_button)

		del_button = new(src)
		del_button.pos(183, 85)
		del_button.set_button_style("✕", "Clear")
		add(del_button)

		rgb_button = new(src)
		rgb_button.pos(183, 66)
		rgb_button.set_button_style("◉", "Color")
		add(rgb_button)

		skin_color_box = new(m)
		add(skin_color_box)

		gender_button = new(src)
		gender_button.pos(197, 37)
		gender_button.set_button_style("⚧", "Gender")
		add(gender_button)

		gender_indicator = new(src, 'Genderindicator.dmi', "maleG")
		gender_indicator.pos(129, 36)
		add(gender_indicator)

		confirm_button = new(src)
		confirm_button.pos(9, 9)
		confirm_button.set_button_style("✓", "Confirm")
		add(confirm_button)

	show()
		..()

	proc/center(var/mob/user)
		pos((user.get_client_width() * 16) - 100, (user.get_client_height() * 16) - 115)

	proc/update_hair(var/mob/user)
		var/mob/M = user
		if(M.makingClone) M = M.clones[M.clones.len]
		var/icon/i = icon(get_hair_icon(user.hair_list[user.hair_scroll_position]))
		i += user.hair_color_position

		appearance_display.overlays = null

		for(var/o in M.hair_stack)
			var image/oo = image(o)
			oo.plane = 100
			appearance_display.overlays += oo


		var image/planedIcon = image(i)
		planedIcon.plane = 100
		appearance_display.overlays += planedIcon

		if(!archive.info_text[user.hair_list[user.hair_scroll_position]])
			archive.info_text[user.hair_list[user.hair_scroll_position]] = drawfont.QuickText(src, user.hair_list[user.hair_scroll_position], "#E6C208", 1, layer = 101000000)
		name_info.display_text(archive.info_text[user.hair_list[user.hair_scroll_position]])
		name_info.pos(115 - round(length(user.hair_list[user.hair_scroll_position]) * 2), 118)

appearance_display
	parent_type = /HudObject
	layer = 101000000
	icon_state = "card1"

appearance_name
	parent_type = /HudObject
	layer = 92000000

	proc/display_text(t)
		overlays = null
		overlays += t

		for(var/index = 1 to overlays.len)
			var image/i = image(overlays[index])
			overlays -= i
			i.plane = plane
			overlays += i

// Clean unified button style
clean_button
	parent_type = /HudObject
	layer = 100000000
	
	icon = 'Blank.dmi'
	icon_state = "blank"
	
	var/button_label = ""
	var/button_tooltip = ""
	var/button_normal_color = "#4a4a4a"  // Dark grey
	var/button_hover_color = "#5a5a5a"   // Lighter grey on hover
	
	mouse_over_pointer = MOUSE_HAND_POINTER
	
	proc/set_button_style(label, tooltip)
		button_label = label
		button_tooltip = tooltip
		color = button_normal_color
		
		// Create visual representation
		var/image/btn_display = image('Blank.dmi', "blank")
		btn_display.color = button_normal_color
		overlays += btn_display
		
		// Add text label if available
		if(label)
			var/image/text_img = image('Blank.dmi', "blank")
			overlays += text_img
	
	proc/set_hover(hovered)
		if(hovered)
			color = button_hover_color
		else
			color = button_normal_color
	
	MouseEntered()
		set_hover(1)
	
	MouseExited()
		set_hover(0)

appearance_back_button
	parent_type = /clean_button

	Click()
		if(--usr.hair_scroll_position < 1)
			usr.hair_scroll_position = usr.hair_list.len
		usr.appearance_box.update_hair(usr)

appearance_forwards_button
	parent_type = /clean_button

	Click()
		if(++usr.hair_scroll_position > usr.hair_list.len)
			usr.hair_scroll_position = 1
		usr.appearance_box.update_hair(usr)

color_box
	parent_type = /HudObject
	layer = 100000000
	var/h_color = "#000000"

	mouse_over_pointer = MOUSE_HAND_POINTER

	Click()
		usr.hair_color_position = h_color
		usr.appearance_box.update_hair(usr)

	MouseEntered()
		overlays += 'Hairglow.dmi'

	MouseExited()
		overlays -= 'Hairglow.dmi'

color_boxes
	parent_type = /HudGroup

	icon = 'Hairbox.dmi'
	layer = 90000000

	var/list/box_colors = list(
	rgb(188, 188, 188),
	rgb(231, 192, 190),
	rgb(134, 132, 84),
	rgb(230, 60, 50),
	rgb(250, 140, 140),
	rgb(140, 100, 125),
	rgb(110, 155, 210),
	rgb(120, 225, 215),
	rgb(145, 220, 115),
	rgb(45, 45, 45),
	rgb(255, 160, 35),
	rgb(230, 75, 0),
	rgb(200, 30, 20),
	rgb(210, 40, 70),
	rgb(65, 35, 125),
	rgb(15, 95, 155),
	rgb(10, 140, 125),
	rgb(50, 140, 15),
	rgb(7, 8, 10),
	rgb(220, 100, 0),
	rgb(75, 40, 20),
	rgb(45, 15, 10),
	rgb(45, 20, 35),
	rgb(30, 30, 40),
	rgb(15, 30, 40),
	rgb(10, 40, 40),
	rgb(20, 60, 0))

	New(mob/m)
		..()

		var/i = 27
		for(var/y = 1 to 3)
			for(var/x = 1 to 9)
				var/px = 174 - (x * 18)
				var/py = 50 + (y * 18)

				var/color_box/color_box = new(src, icon, "[i]")
				color_box.h_color = box_colors[i]
				color_box.pos(px, py)
				add(color_box)

				i--

skin_box
	parent_type = /HudObject
	layer = 100000000
	var/id = 4

	mouse_over_pointer = MOUSE_HAND_POINTER

	Click()
		var/mob/M = usr
		if(M.makingClone) M = M.clones[M.clones.len]
		M.update_base(id)
		usr.appearance_box.appearance_display.icon = M.icon

	MouseEntered()
		overlays += 'Hairglow.dmi'

	MouseExited()
		overlays -= 'Hairglow.dmi'

skin_color_box
	parent_type = /HudGroup

	icon = 'Skinbox.dmi'
	layer = 90000000

	New(mob/m)
		..()

		var/i = 6
		for(var/x = 1 to 6)
			var/px = 120 - (x * 18)

			var/skin_box/skin_box = new
			skin_box = new(src, icon, "[i]")
			skin_box.id = i
			skin_box.pos(px, 38)
			add(skin_box)

			i--

gender_indicator
	parent_type = /HudObject
	layer = 100000000

gender_button
	parent_type = /clean_button

	Click()
		var/mob/M = usr
		if(M.makingClone) M = M.clones[M.clones.len]
		if(M.Female)
			M.Female = 0
			M.Gender = "male"
			usr.appearance_box.gender_indicator.icon_state = "maleG"
		else
			M.Female = 1
			M.Gender = "female"
			usr.appearance_box.gender_indicator.icon_state = "femaleG"
		usr.FixIcon(M)
		usr.appearance_box.appearance_display.icon = M.icon

add_button
	parent_type = /clean_button

	Click()
		var/mob/M = usr
		if(M.makingClone) M = M.clones[M.clones.len]
		var/icon/i = icon(get_hair_icon(usr.hair_list[usr.hair_scroll_position]))
		i += usr.hair_color_position
		M.hair_stack += i
		usr.appearance_box.update_hair(M)

del_button
	parent_type = /clean_button

	Click()
		var/mob/M = usr
		if(M.makingClone) M = M.clones[M.clones.len]
		M.hair_stack = list()
		usr.appearance_box.update_hair(M)

rgb_button
	parent_type = /clean_button

	Click()
		var/mob/M = usr
		if(M.makingClone) M = M.clones[M.clones.len]
		usr.hair_color_position = input("Please select an RGB color") as color
		usr.appearance_box.update_hair(M)

confirm_button
	parent_type = /clean_button
	layer = 200000000

	Click()
		var/mob/M = usr
		if(M.makingClone) M = M.clones[M.clones.len]
		usr.beep()
		usr.appearance_box.hide()
		var/icon/i = icon(get_hair_icon(usr.hair_list[usr.hair_scroll_position]))
		i += usr.hair_color_position
		M.hair_stack += i
		M.icon = usr.appearance_box.appearance_display.icon
		M.overlays += usr.appearance_box.appearance_display.overlays
		M.character_box.avatar_box.icon = M
		M.character_box.avatar_box.overlays += M.overlays
		
		// Restore character visibility when menu closes
		M.invisibility = M.saved_invisibility
		M.overlays = M.saved_overlays.Copy()
		M.icon = M.saved_icon
		
		if(usr.makingClone) usr.makingClone = 0

area/title_area
	icon = 'Titlearea.dmi'
	layer = 1
	mouse_opacity = 0

/proc/get_hair_icon(hairstyle)
	switch(hairstyle)
		if("Bald")
			return null
		if("Messy Ponytail")
			return 'Messy_Ponytail.dmi'
		if("Short Spiky Ponytail")
			return 'Mini_Spiky_Ponytail.dmi'
		if("Noble")
			return 'Noble.dmi'
		if("Rough")
			return 'Rough_Cut.dmi'
		if("Sideswept")
			return 'Sideswept.dmi'
		if("Thug")
			return 'Thug.dmi'
		if("Twintails")
			return 'Twintails.dmi'
		if("LA Hair")
			return 'lahair.dmi'
		if("Braid")
			return 'Braid.dmi'
		if("Girl Next Door")
			return 'hair1.dmi'
		if("Skrillex")
			return 'hair2.dmi'
		if("R-Skrilly")
			return 'reverse-skrillex.dmi'
		if("Lightning")
			return 'hair3.dmi'
		if("Untidy")
			return 'a.dmi'
		if("Back Pigtail")
			return 'b.dmi'
		if("Buns")
			return 'c.dmi'
		if("Rihanna")
			return 'hair5.dmi'
		if("Bangs 2")
			return 'hair4.dmi'
		if("Bowl Cut")
			return 'Hair_Bowl.dmi'
		if("Orderly")
			return 'Hair_Hinata.dmi'
		if("Double Topknot Male")
			return 'Hair_Choji.dmi'
		if("Buzzcut")
			return 'Hair_Villager.dmi'
		if("Short Spikey")
			return 'Hair_Juugo.dmi'
		if("Long Ponytail")
			return 'Tsunade.dmi'
		if("Slanted Top")
			return 'Hair_Kakashi.dmi'
		if("Gelled Top")
			return 'Hair_Kisame.dmi'
		if("Short-cut")
			return 'Hair_Short.dmi'
		if("Topknot")
			return 'Hair_Chiyo.dmi'
		if("Wild Long")
			return 'Jiraiya.dmi'
		if("Bangs")
			return 'Hair_Emo.dmi'
		if("Trimmed Long")
			return 'Hair_Wild.dmi'
		if("Loose Ponytail")
			return 'Hair_Loose_Ponytail.dmi'
		if("Long")
			return 'Hair_Long.dmi'
		if("Balding")
			return 'Hair_Little.dmi'
		if("Ponytail")
			return 'Hair_Ponytail.dmi'
		if("Loose")
			return 'Hair_Sakura.dmi'
		if("Spiked Back")
			return 'Hair_Sasuke.dmi'
		if("Uncombed")
			return 'Hair_Naruto.dmi'
		if("Spikey")
			return 'Hair_Spikey.dmi'
		if("Messy Gel")
			return 'Hair_Spikey2.dmi'
		if("Ski-jump")
			return 'Hair_Spikey3.dmi'
		if("Double Topknot Female")
			return 'Hair_Tenten.dmi'
		if("Mohawk")
			return 'Hair_Mohawk.dmi'
		if("Afro")
			return 'Afro.dmi'
		if("Messy Afro")
			return 'Hair_Crazy-Afro.dmi'
		if("Messy")
			return 'Hair_Crazy.dmi'
		if("Unbrushed")
			return 'Hair_Untidy.dmi'
		if("Bed Head")
			return 'a.dmi'
		if("Side Spikey Pig Tail")
			return 'b.dmi'
		if("Two Spikey Pig Tail")
			return 'c.dmi'
		if("Tomboy")
			return 'tomboy.dmi'
		if("Cloud Strife")
			return 'e.dmi'
		if("Braided")
			return 'Hair_Braided.dmi'
		if("Ditsy")
			return 'Hair_Ditsy.dmi'
		if("Dreads")
			return 'Hair_Dreads.dmi'
		if("Long Emo")
			return 'Hair_EmoLong.dmi'
		if("Lolly")
			return 'Hair_Lolly.dmi'
		if("Long Flowing")
			return 'Hair_LongFlowing.dmi'
		if("Long Tail")
			return 'Hair_Longtail.dmi'
		if("Nanoa")
			return 'Hair_Nanoa.dmi'
		if("Oriental")
			return 'Hair_Oriental.dmi'
		if("Parted")
			return 'Hair_Parted.dmi'
		if("Pigtails")
			return 'Hair_Pigtails.dmi'
		if("Pretty Long")
			return 'Hair_PrettyLong.dmi'
		if("Short Parted")
			return 'Hair_ShortParted.dmi'
		if("Deidara")
			return 'Deidara.dmi'
		if("New Spikey")
			return 'Hair_Spikey.dmi'
		if("Dreadlocks")
			return 'Dreadlocks.dmi'
		if("Emo2")
			return 'Emo2.dmi'
		if("Front Tails")
			return 'FT.dmi'
		if("Front Tails Longs")
			return 'FTL.dmi'
		if("Gohan")
			return 'Gohan.dmi'
		if("Haku")
			return 'Haku.dmi'
		if("Jiraiya")
			return 'Jiraiya.dmi'
		if("Madara")
			return 'Madara.dmi'
		if("Messy2")
			return 'Messy2.dmi'
		if("Minato")
			return 'Minato.dmi'
		if("Mizukage")
			return 'Mizukage.dmi'
		if("Orochimaru")
			return 'Orochimaru.dmi'
		if("Karn")
			return 'Karn.dmi'
		if("RichKid")
			return 'RichKid.dmi'
		if("Ryuzaki")
			return 'Ryuzaki.dmi'
		if("Seven1")
			return 'SevenHair1.dmi'
		if("Seven2")
			return 'SevenHair2.dmi'
		if("Sleek")
			return 'Sleek.dmi'
		if("Super")
			return 'Super.dmi'
		if("Thick")
			return 'Thick.dmi'
		if("Tousen")
			return 'Tousen.dmi'
		if("Tsunade")
			return 'Tsunade.dmi'
		if("Umir")
			return 'Umir.dmi'
		if("Valnium")
			return 'Valnium1.dmi'
		if("Valnium2")
			return 'Valnium2.dmi'
		if("Yahair")
			return 'Yahair.dmi'
		else
			// Catch-all for any missing hairstyles - logs the issue and returns null
			world.log << "WARNING: Missing hairstyle icon mapping for '[hairstyle]'"
			return null
