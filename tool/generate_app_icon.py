"""Generates the Kartly app icon (brand-purple shopping bag) as PNGs.

Outputs:
  assets/icon/icon.png            1024x1024, purple background + white bag
  assets/icon/icon_foreground.png 1024x1024, transparent + white bag (adaptive)

Run: python tool/generate_app_icon.py
Then: dart run flutter_launcher_icons
"""
import os
from PIL import Image, ImageDraw, ImageFont

SS = 4               # supersample factor for smooth edges
OUT = 1024
BASE = OUT * SS
PURPLE_TOP = (0x7A, 0x66, 0xB8)
PURPLE_BOTTOM = (0x57, 0x40, 0x8E)
ASSET_DIR = os.path.join(os.path.dirname(__file__), "..", "assets", "icon")


def s(v):
    return int(v * SS)


def _load_font(size):
    for name in ("ariblk.ttf", "arialbd.ttf", "segoeuib.ttf", "calibrib.ttf"):
        path = os.path.join("C:\\", "Windows", "Fonts", name)
        if os.path.exists(path):
            return ImageFont.truetype(path, size)
    return None


def build_glyph():
    """White shopping-bag glyph on a transparent BASE canvas."""
    mask = Image.new("L", (BASE, BASE), 0)
    d = ImageDraw.Draw(mask)
    # Handle: white ring (outer ellipse minus inner hole), upper half visible.
    d.ellipse([s(372), s(300), s(652), s(600)], fill=255)
    d.ellipse([s(420), s(348), s(604), s(552)], fill=0)
    # Bag body: rounded rectangle that covers the ring's lower half.
    d.rounded_rectangle([s(300), s(452), s(724), s(824)], radius=s(64), fill=255)

    # Cut a bold lowercase "k" monogram out of the bag (shows the background
    # through it) so the mark clearly reads as Kartly, not a padlock.
    font = _load_font(s(300))
    if font is not None:
        d.text((s(512), s(646)), "k", font=font, fill=0, anchor="mm")

    glyph = Image.new("RGBA", (BASE, BASE), (0, 0, 0, 0))
    white = Image.new("RGBA", (BASE, BASE), (255, 255, 255, 255))
    glyph = Image.composite(white, glyph, mask)
    return glyph


def gradient_bg():
    col = Image.new("RGB", (1, 256))
    for y in range(256):
        t = y / 255
        col.putpixel(
            (0, y),
            tuple(int(PURPLE_TOP[i] + (PURPLE_BOTTOM[i] - PURPLE_TOP[i]) * t) for i in range(3)),
        )
    return col.resize((BASE, BASE)).convert("RGBA")


def place(glyph, frac, bg=None):
    """Center the glyph at `frac` of the canvas, optionally over a background."""
    g = glyph.crop(glyph.getbbox())
    box = int(BASE * frac)
    r = min(box / g.width, box / g.height)
    g = g.resize((max(1, int(g.width * r)), max(1, int(g.height * r))), Image.LANCZOS)
    canvas = Image.new("RGBA", (BASE, BASE), (0, 0, 0, 0))
    canvas.alpha_composite(g, ((BASE - g.width) // 2, (BASE - g.height) // 2))
    if bg is not None:
        out = bg.copy()
        out.alpha_composite(canvas)
        canvas = out
    return canvas.resize((OUT, OUT), Image.LANCZOS)


def main():
    os.makedirs(ASSET_DIR, exist_ok=True)
    glyph = build_glyph()

    # Full icon: glyph at 60% over the brand gradient (flattened to RGB).
    icon = place(glyph, 0.60, gradient_bg()).convert("RGB")
    icon.save(os.path.join(ASSET_DIR, "icon.png"))

    # Adaptive foreground: glyph at 52% (smaller, for the safe zone), transparent.
    fg = place(glyph, 0.52, None)
    fg.save(os.path.join(ASSET_DIR, "icon_foreground.png"))

    print("Wrote icon.png and icon_foreground.png to assets/icon/")


if __name__ == "__main__":
    main()
