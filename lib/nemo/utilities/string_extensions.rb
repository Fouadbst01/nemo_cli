class String
    COLORS = {
        red: 31,
        green: 32,
        yellow: 33,
        blue: 34,
        magenta: 35,
        cyan: 36,
        white: 37
    }

    STYLES = {
        bold: 1,
        italic: 3,
        underline: 4
    }

    def colorize(color)
        color_code = COLORS[color] || COLORS[:white]
        "\033[#{color_code}m#{self}\033[0m"
    end

    def style(style)
        style_code = STYLES[style] || 0
        "\033[#{style_code}m#{self}\033[0m"
    end

    def colorize_and_style(color, style)
        color_code = COLORS[color] || COLORS[:white]
        style_code = STYLES[style] || 0
        "\033[#{color_code};#{style_code}m#{self}\033[0m"
    end
end