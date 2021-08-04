pub struct Canvas {

    pub let width: UInt8
    pub let height: UInt8
    pub let pixels: String

    init(width: UInt8, height: UInt8, pixels: String) {
        self.width = width
        self.height = height
        // 123
        // 456
        // 789
        // ==> 123456789
        self.pixels = pixels
    }
}

pub resource Picture {
    pub let canvas: Canvas

    init(canvas: Canvas) {
        self.canvas = canvas
    }
}

pub fun serializeStringArray(_ lines: [String]): String {
    var buffer = ""
    for line in lines {
        buffer = buffer.concat(line)
    }

    return buffer
}

pub fun display(canvas: Canvas) {
    fun createBoarder(width width: UInt8): String {
        var boarderWidth: UInt8 = 0

        var boarder = ""
        while boarderWidth < width {
            boarder = boarder.concat("-")
            boarderWidth = boarderWidth + 1
        }
        return "+".concat(boarder).concat("+")
    }

    var boarder = createBoarder(width: canvas.width)
    log(boarder)

    var i = 0
    var line = ""
    while i < canvas.pixels.length {
        line = canvas.pixels.slice(from: i, upTo: i + Int(canvas.width))
        log("|".concat(line).concat("|"))
        line = ""
        i = i + Int(canvas.width)
    }
    log(boarder)
}

pub fun main() {
    let pixelsX = [
        "*   *",
        " * * ",
        "  *  ",
        " * * ",
        "*   *"
    ]

    let canvasX = Canvas(
        width: 5,
        height: 5,
        pixels: serializeStringArray(pixelsX)
    )

    display(canvas: canvasX)
}