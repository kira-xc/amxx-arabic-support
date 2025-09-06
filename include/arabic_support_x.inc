#if defined _arabic_support_x_included
	#endinput
#endif
#define _arabic_support_x_included

#if AMXX_VERSION_NUM >= 175
	#pragma reqlib arabic_support_x
	#if !defined AMXMODX_NOAUTOLOAD
		#pragma loadlib arabic_support_x
	#endif
#else
	#pragma library arabic_support_x
#endif

/**
 * Checks whether a given string contains Arabic characters or not.
 *
 * @param       text - The string to be checked.
 *
 * @return      True if the text contains at least one Arabic character,
 *              false otherwise.
 *
 * @note        This function only validates the presence of Arabic characters,
 *              it does not check for full Arabic grammar or word correctness.
 */
native is_arabic_text(const text[]);

/**
 * Fixes Arabic text to be displayed correctly in-game or in supported clients.
 *
 * The function replaces Arabic characters with their mapped equivalents and
 * reverses the word order so that the text is shown from left to right.
 *
 * @param       text - The Arabic string to be fixed. The result will overwrite
 *                     the same string.
 *
 *
 * @note        This function modifies the string in place.
 */
native arabic_fix_text(text[]);