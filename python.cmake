include(${CMAKE_CURRENT_LIST_DIR}/helpers/PyQt5TranslationMacros.cmake)

macro(do_python_project)
	find_package(Qt5LinguistTools)

	if(${create_translations})

		if(EXISTS "${CMAKE_SOURCE_DIR}/__init__.py")
			set(src_dir ${CMAKE_SOURCE_DIR})
		else()
			set(src_dir ${CMAKE_SOURCE_DIR}/src)
		endif()

		file(GLOB_RECURSE objects LIST_DIRECTORIES true ${src_dir}/*)

		set(dirs "")
		foreach(o ${objects})
			if(IS_DIRECTORY ${o})
				list(APPEND dirs ${o})
			endif()
		endforeach()

		pyqt5_create_translation(
			qm_files
			${src_dir} ${dirs} ${additional_translations}
			${src_dir}/${PROJECT_NAME}_en.ts
		)
	endif()

	add_custom_target(translations ALL DEPENDS ${qm_files})

	file(GLOB_RECURSE source_files CONFIGURE_DEPENDS *.py)

	set(input_files
		${source_files}
		${qm_files})
endmacro()
