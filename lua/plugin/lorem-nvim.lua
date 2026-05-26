return {
	"derektata/lorem.nvim",
	cmd = { "Lorem", "LoremLine" },
	config = function()
		require("lorem").opts({
			format_defaults = {
				short = { w_per_sentence = 5, s_per_paragraph = 3 },
				medium = { w_per_sentence = 10, s_per_paragraph = 5 },
				long = { w_per_sentence = 14, s_per_paragraph = 7 },
				mixedShort = { w_per_sentence = 8, s_per_paragraph = 4 },
				mixed = { w_per_sentence = 12, s_per_paragraph = 6 },
				mixedLong = { w_per_sentence = 16, s_per_paragraph = 8 },
			},
			sentence_length = "mixed", -- using a default configuration
			comma_chance = 0.3, -- 30% chance to insert a comma
			max_commas = 2, -- maximum 2 commas per sentence
			debounce_ms = 200, -- default debounce time in milliseconds
		})
	end,
}
