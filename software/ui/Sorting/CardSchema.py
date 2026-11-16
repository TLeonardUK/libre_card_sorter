from enum import Enum, StrEnum

class CardFieldType(Enum):
    TEXT = 1
    NUMBER = 2
    LIST = 3

class CardFieldName(StrEnum):
    RARITY = "rarity"
    SET = "set"
    SET_NAME = "set_name"
    TYPE_LINE = "type_line"
    MANA_COST = "mana_cost"
    POWER = "power"
    TOUGHNESS = "toughness"
    FLAVOR_TEXT = "flavor_text"
    COLORS = "colors"
    KEYWORDS = "keywords"
    FINISHES = "finishes"
    PRICE_USD = "price.usd"
    PRICE_USD_FOIL = "price.usd_foil"
    PRICE_USD_NONFOIL = "price.usd_nonfoil"
    IS_FOIL = "is_foil"

class CardRarity(StrEnum):
    COMMON = "common"
    UNCOMMON = "uncommon"
    RARE = "rare"
    MYTHIC = "mythic"
    SPECIAL = "special"
    BONUS = "bonus"

class CardColor(StrEnum):
    WHITE = "W"
    BLUE = "U"
    BLACK = "B"
    RED = "R"
    GREEN = "G"

class CardFinish(StrEnum):
    NONFOIL = "nonfoil"
    FOIL = "foil"
    ETCHED = "etched"

class CardBoolean(StrEnum):
    TRUE = "1"
    FALSE = "0"

class CardField:
    def __init__(self, name, field_type, values=None):
        self.name = name
        self.type = field_type
        self.values = values

CARD_FIELDS = [
    CardField(CardFieldName.RARITY,             CardFieldType.TEXT,     CardRarity),
    CardField(CardFieldName.SET,                CardFieldType.TEXT),
    CardField(CardFieldName.SET_NAME,           CardFieldType.TEXT),
    CardField(CardFieldName.TYPE_LINE,          CardFieldType.TEXT),
    CardField(CardFieldName.MANA_COST,          CardFieldType.TEXT),
    CardField(CardFieldName.POWER,              CardFieldType.TEXT),
    CardField(CardFieldName.TOUGHNESS,          CardFieldType.TEXT),
    CardField(CardFieldName.FLAVOR_TEXT,        CardFieldType.TEXT),
    CardField(CardFieldName.COLORS,             CardFieldType.LIST,     CardColor),
    CardField(CardFieldName.KEYWORDS,           CardFieldType.LIST),
    CardField(CardFieldName.FINISHES,           CardFieldType.LIST,     CardFinish),
    CardField(CardFieldName.PRICE_USD,          CardFieldType.NUMBER),
    CardField(CardFieldName.PRICE_USD_FOIL,     CardFieldType.NUMBER),
    CardField(CardFieldName.PRICE_USD_NONFOIL,  CardFieldType.NUMBER),
    CardField(CardFieldName.IS_FOIL,            CardFieldType.TEXT,     CardBoolean),
]

def find_card_field(name):
    for field in CARD_FIELDS:
        if (field.name == name):
            return field
    return None
