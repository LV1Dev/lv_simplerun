Config = {}

Config.Ped = {
    model = "a_m_m_og_boss_01", -- drug dealer ped model https://docs.fivem.net/docs/game-references/ped-models/
    coords = {x = 310.2628, y = 354.5193, z = 105.3227, heading = 259.0787} -- start mission/dealer location
}

Config.BuyerModel = "a_f_m_skidrow_01" -- buyer model

Config.Buyers = {
    {x = 97.0808, y = -1955.4114, z = 20.7448, heading = 338.3138}, -- buyer 1
	{x = 157.8403, y = -1899.6351, z = 22.9943, heading = 301.9703}, -- buyer 2
	{x = 188.9347, y = -1811.8705, z = 28.8734, heading = 338.8972}, -- buyer 3
	{x = -99.7447, y = -1518.4464, z = 33.6610, heading = 131.0143}, -- buyer 4
	{x = 138.6984, y = -421.8292, z = 41.1364, heading = 252.9248}, -- buyer 5
	{x = 500.9456, y = -1684.9652, z = 29.2414, heading = 314.9492}, -- buyer 6
	{x = -745.3797, y = -1076.1206, z = 11.8037, heading = 293.6803}, -- buyer 7
	{x = -1350.5897, y = -675.6757, z = 25.6893, heading = 212.8545}, -- buyer 8
	{x = 1222.6029, y = -1295.4302, z = 35.3680, heading = 276.8539}, -- buyer 9
	{x = 1388.3920, y = -739.0798, z = 67.1829, heading = 84.6785}, -- buyer 10
	-- add more locations here. buyer is selected randomly
}

Notifications = {
    ["HEROIN"] = {
        ["BUYER_MARKED"] = "Buyer marked on map", -- feel free to translate to your own language 
        ["SOLD_ITEM"] = "You sold %s for %s$", -- feel free to translate to your own language 
        ["NO_ITEM"] = "You dont have any %s" -- feel free to translate to your own language 
    }
}

Config.Texts = {
    SellBaggie = "Press E to sell baggie", -- sell item text / feel free to translate to your own language 
    StartDelivery = "Press E to start heroin delivery" -- start mission text / feel free to translate to your own language 
}

Config.Item = "heroin" -- change to your item name
Config.Price = 500 -- config your own price per unit of item
