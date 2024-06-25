//+------------------------------------------------------------------+
//|                                         BackgroundSymbolInfo.mq5 |
//|                                            Copyright 2024, junmt |
//|                                   https://twitter.com/SakenomiFX |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, junmt"
#property link "https://twitter.com/SakenomiFX"
#property version "1.00"

//+-------------------------------------------------------------------------------------------+
//| Indicator Global Inputs                                                                   |
//+-------------------------------------------------------------------------------------------+
input int indicator_font_size = 100;           // フォントサイズ
input color indicator_color = C'235,235,235'; // 色

//+-------------------------------------------------------------------------------------------+
//| Custom indicator initialization function                                                  |
//+-------------------------------------------------------------------------------------------+
void OnInit()
{
    CreateSymbolName();
}

int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &Time[],
                const double &Open[],
                const double &High[],
                const double &Low[],
                const double &Close[],
                const long &Volume[],
                const long &volume[],
                const int &spread[])
{
    return (rates_total);
}
//+------------------------------------------------------------------+
//| Indicator deinitialization function                              |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    ObjectDelete(0, "SymbolName");
}

//+------------------------------------------------------------------+
//| 画面の中心にシンボル名を大きく表示する                                        |
//+------------------------------------------------------------------+
void CreateSymbolName()
{
    string name = "SymbolName";
    string symbol_name = _Symbol + " " + getTimeframeName();

    ObjectCreate(0, name, OBJ_LABEL, 0, 0, 0);
    ObjectSetString(0, name, OBJPROP_TEXT, symbol_name);
    ObjectSetInteger(0, name, OBJPROP_COLOR, indicator_color);
    ObjectSetInteger(0, name, OBJPROP_FONTSIZE, indicator_font_size);
    ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
    ObjectSetInteger(0, name, OBJPROP_XDISTANCE, (int)((ChartGetInteger(0, CHART_WIDTH_IN_PIXELS) - TextGetWidth(symbol_name, indicator_font_size)) / 2));
    ObjectSetInteger(0, name, OBJPROP_YDISTANCE, (int)((ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS) - TextGetHeight(indicator_font_size)) / 2));
    ObjectSetInteger(0, name, OBJPROP_XSIZE, TextGetWidth(symbol_name, indicator_font_size));
    ObjectSetInteger(0, name, OBJPROP_YSIZE, TextGetHeight(indicator_font_size));
    ObjectSetInteger(0, name, OBJPROP_BACK, true); // 背景に表示する設定
}
//+------------------------------------------------------------------+
//| Calculate text width in pixels                                   |
//+------------------------------------------------------------------+
int TextGetWidth(const string text, const int fontsize)
{
    // テキストの幅を計算（簡略化した計算方法）
    return StringLen(text) * fontsize;
}
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Calculate text height in pixels                                  |
//+------------------------------------------------------------------+
int TextGetHeight(const int fontsize)
{
    // テキストの高さを計算
    return fontsize;
}

string getTimeframeName()
{
    string TT, TP;
    if (_Period < PERIOD_H1)
    {
        TT = "M";
        TP = IntegerToString(_Period);
    }
    else if (_Period >= PERIOD_H1 && _Period < PERIOD_D1)
    {
        TT = "H";
        TP = IntegerToString(_Period - 16384);
    }
    else if (_Period == PERIOD_D1)
    {
        TT = "D";
        TP = "1";
    }
    else if (_Period == PERIOD_W1)
    {
        TT = "W";
        TP = "1";
    }
    else
    {
        TT = "MN";
        TP = "1";
    }
    return TT + TP;
}

//+-------------------------------------------------------------------------------------------+
//|Custom indicator end                                                                       |
//+-------------------------------------------------------------------------------------------+