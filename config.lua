Config = {}

Config.SQL = 'oxmysql' --- oxmysql or ghmattisql

Config.Eye = "true" 

Config.PedModel = "a_m_m_farmer_01" 
Config.PedHash = 0x94562DD7  

Config.Seller = {
    coords = vector4(1551.04, 2189.86, 77.84, 0.89),
}

Config.Prices = {
    ['wood_pro'] = {100, 100}
}

 Config.Locations = {
    ["garden"] = {
        [1] = {label = ('Flower Garden'), coords = vector4(1581.29, 2165.82, 79.34, 77.12)}
    },
    ["floseller"] = {
        [1] = {label = ('Flower Seller'), coords = vector4(1551.04, 2189.86, 78.84, 0.89)}
    },
}

Config.Items = {
    label = 'flowershop',
    slots = 5,
    items = {
        [1] = {
            name = "flower_paper",
            price = 10,
            amount = 50,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "emp_flower_box",
            price = 10,
            amount = 50,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "emp_bucket",
            price = 50,
            amount = 1,
            info = {},
            type = "item",
            slot = 3,
        },
    }
}

Config.ProcessName = {
    ['pickflower'] = 'Picking Flowers...',
    ['proflowers'] = 'Processing Flowers...',
    ['packflowers'] = 'Packing Flowers...',
    ['sellflowers'] = 'Selling Flowers...',
    ['openshop'] = 'Open Shop',
}

Config.ProcessTime = {
    ['pickflower'] = '5000',
    ['proflowers'] = '5000',
    ['packflowers'] = '5000',
    ['sellflowers'] = '4000',
    ['openshop'] = '4000',
}

Config.Notify = {
    ['cancel'] = "Cancelled..",
    ['bucket'] = "You Dont Have Bucket..",
    ['no_item'] = "You Dont Have Right Items..",
    ['no_sell_item'] = "You dont have Flower Boxes..",
    ['openshop'] = "Opened Shop.."
}