//
//  AndesCurrenciesTestAppDefault.swift
//  AndesUI-AndesUIResources
//
//  Created by Daniel Esteban Beltran Beltran on 20/09/21.
//

import Foundation

@objc public class AndesCurrenciesDefault: NSObject, AndesCurrencies {
    public var currentSite = AndesCountry.DEFAULT.toString()

    public var currencies: [String: AndesCurrencyInfo] = [
        "ARS": AndesCurrencyInfo(decimalSeparator: ",", thousandSeparator: ".", symbol: "$", decimalPlaces: "2", decimalName: "Centavo", currencyName: "Peso", decimalNamePrural: "Centavo", currencyNamePrural: "Pesos"),
        "BRL": AndesCurrencyInfo(decimalSeparator: ",", thousandSeparator: ".", symbol: "R$", decimalPlaces: "2", decimalName: "Centavo", currencyName: "Real", decimalNamePrural: "Centavos", currencyNamePrural: "Reales"),
        "CLP": AndesCurrencyInfo(decimalSeparator: ",", thousandSeparator: ".", symbol: "$", decimalPlaces: "0", decimalName: "Centavo", currencyName: "Peso", decimalNamePrural: "Centavos", currencyNamePrural: "Pesos"),
        "COP": AndesCurrencyInfo(decimalSeparator: ",", thousandSeparator: ".", symbol: "$", decimalPlaces: "0", decimalName: "Centavo", currencyName: "Peso", decimalNamePrural: "Centavos", currencyNamePrural: "Pesos"),
        "CRC": AndesCurrencyInfo(decimalSeparator: ".", thousandSeparator: ",", symbol: "¢", decimalPlaces: "2", decimalName: "Céntimo", currencyName: "Colón", decimalNamePrural: "Céntimos", currencyNamePrural: "Colónes"),
        "DOP": AndesCurrencyInfo(decimalSeparator: ".", thousandSeparator: ",", symbol: "$", decimalPlaces: "2", decimalName: "Centavo", currencyName: "Peso", decimalNamePrural: "Centavos", currencyNamePrural: "Pesos"),
        "EUR": AndesCurrencyInfo(decimalSeparator: ".", thousandSeparator: ",", symbol: "€", decimalPlaces: "2", decimalName: "Cent", currencyName: "Euro", decimalNamePrural: "Cents", currencyNamePrural: "Euros"),
        "MXN": AndesCurrencyInfo(decimalSeparator: ".", thousandSeparator: ",", symbol: "$", decimalPlaces: "2", decimalName: "Centavo", currencyName: "Peso", decimalNamePrural: "Centavos", currencyNamePrural: "Pesos"),
        "PAB": AndesCurrencyInfo(decimalSeparator: ",", thousandSeparator: ".", symbol: "B/.", decimalPlaces: "2", decimalName: "Centésimo", currencyName: "Balboa", decimalNamePrural: "Centésimos", currencyNamePrural: "Balboas"),
        "PEN": AndesCurrencyInfo(decimalSeparator: ",", thousandSeparator: ".", symbol: "S/", decimalPlaces: "2", decimalName: "Céntimo", currencyName: "Sol", decimalNamePrural: "Céntimos", currencyNamePrural: "Soles"),
        "USD": AndesCurrencyInfo(decimalSeparator: ",", thousandSeparator: ".", symbol: "U$S", decimalPlaces: "2", decimalName: "Centavo", currencyName: "Dolar", decimalNamePrural: "Centavos", currencyNamePrural: "Dolares"),
        "UYU": AndesCurrencyInfo(decimalSeparator: ",", thousandSeparator: ".", symbol: "$", decimalPlaces: "2", decimalName: "Centavo", currencyName: "Peso", decimalNamePrural: "Centavos", currencyNamePrural: "Pesos"),
        "VEF": AndesCurrencyInfo(decimalSeparator: ",", thousandSeparator: ".", symbol: "Bs.", decimalPlaces: "2", decimalName: "Centavo", currencyName: "Bolivar", decimalNamePrural: "Centavos", currencyNamePrural: "Bolívares"),
        "VES": AndesCurrencyInfo(decimalSeparator: ",", thousandSeparator: ".", symbol: "Bs.", decimalPlaces: "2", decimalName: "Centavo", currencyName: "Bolivar", decimalNamePrural: "Centavos", currencyNamePrural: "Bolívares"),
        "CLF": AndesCurrencyInfo(decimalSeparator: ",", thousandSeparator: ".", symbol: "UF", decimalPlaces: "2", decimalName: "Centavo", currencyName: "Unidad de fomento", decimalNamePrural: "Centavos", currencyNamePrural: "Unidades de fomento"),
        "BOB": AndesCurrencyInfo(decimalSeparator: ",", thousandSeparator: ".", symbol: "Bs", decimalPlaces: "2", decimalName: "Centavo", currencyName: "Boliviano", decimalNamePrural: "Centavos", currencyNamePrural: "Bolivianos"),
        "PYG": AndesCurrencyInfo(decimalSeparator: ",", thousandSeparator: ".", symbol: "₲", decimalPlaces: "0", decimalName: "Céntimo", currencyName: "Guaraní", decimalNamePrural: "Céntimos", currencyNamePrural: "Guaraníes"),
        "GTQ": AndesCurrencyInfo(decimalSeparator: ",", thousandSeparator: ".", symbol: "Q", decimalPlaces: "2", decimalName: "Centavo", currencyName: "Quetzal", decimalNamePrural: "Centavos", currencyNamePrural: "Quetzales"),
        "HNL": AndesCurrencyInfo(decimalSeparator: ",", thousandSeparator: ".", symbol: "L", decimalPlaces: "0", decimalName: "Centavo", currencyName: "Lempira", decimalNamePrural: "Centavos", currencyNamePrural: "Lempiras"),
        "NIO": AndesCurrencyInfo(decimalSeparator: ",", thousandSeparator: ".", symbol: "C$", decimalPlaces: "0", decimalName: "Centavo", currencyName: "Córdoba", decimalNamePrural: "Centavos", currencyNamePrural: "Córdobas"),
        "CUC": AndesCurrencyInfo(decimalSeparator: ",", thousandSeparator: ".", symbol: "$", decimalPlaces: "2", decimalName: "", currencyName: "Peso cubano convertible", decimalNamePrural: "", currencyNamePrural: "Pesos cubanos convertibles")
        ]

    public var sites: [String: AndesSiteInfo] = [
        "MNI": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MLC": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MLV": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MHN": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MPY": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MBO": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MLU": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MCR": AndesSiteInfo(decimalSeparator: ".", thousandSeparator: ","),
        "MLM": AndesSiteInfo(decimalSeparator: ".", thousandSeparator: ","),
        "MSV": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MGT": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MPA": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MRD": AndesSiteInfo(decimalSeparator: ".", thousandSeparator: ","),
        "MLA": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MCO": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MPE": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MPR": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MCU": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MLB": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: "."),
        "MEC": AndesSiteInfo(decimalSeparator: ",", thousandSeparator: ".")]
}
