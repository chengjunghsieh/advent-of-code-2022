Advent of Code 2022
===

# Day 17

Part 2

要找第1000000000000個掉落的岩石的高度。

直覺的作法是尋找cycle，用`[掉落順序ID, 操作順序ID]`當Key，`[第i個掉落, 掉落前的高度]`當Value，如果Key，重複的話就有cycle。

但這個作法有個問題，2次底下磚塊的排列可能長相不同，所以找到的未必是真的在cycle上。

一個heuristic是 如果Key出現3次 就認為他是Cycle。

# Day 18

Part 1

算表面積

Part 2

不計算容器內部的表面積。

從不屬於容器的任一點開始bfs,計算接觸到容器的次數。

# Day 21

Part 2

解一元一次方程式。

注意：題目限制、浮點數問題

# Day 22

Part 2

給立方體的平面圖上，模擬在立方體上行走。