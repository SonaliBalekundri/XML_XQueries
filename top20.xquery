<top20>
    <tops
        id="top20">
        <heading>
            D. TABLE CONTAINS THE TOP 20 PROBABILITY RECORDS
        </heading>
        <table
            style="font-family: arial, sans-serif; border-collapse: collapse; width: 10%;">
            <tr>
                <th
                    style="border: 1px solid #dddddd; text-align: center; padding: 8px; background-color: #dddddd">Target</th>
                <th
                    style="border: 1px solid #dddddd; text-align: center; padding: 8px; background-color: #dddddd">Successor</th>
                <th
                    style="border: 1px solid #dddddd; text-align: center; padding: 8px; background-color: #dddddd">Top20 Probability</th>
            </tr>
            {
                let $files := collection("./?select=*xml")/bncDoc
                let $combined :=
                for $has in $files//w[normalize-space(lower-case(.)) = "has"]
                let $next := $has/following-sibling::w[1]
                let $has_word := normalize-space($has)
                let $next_word := normalize-space($next)
                    where $next
                return
                    concat($has_word, ' ', $next_word)
                
                let $doc := collection("./?select=*xml")/bncDoc//w
                let $top20probs :=
                for $unique_word in distinct-values($combined)
                let $frequency := count($combined[. = $unique_word])
                let $has_word := tokenize($unique_word, ' ')[1]
                let $next_word := tokenize($unique_word, ' ')[2]
                let $list_of_words := $doc[normalize-space(lower-case(.)) = $next_word]
                
                let $succ_word :=
                count($list_of_words)
                
                let $prob :=
                if ($succ_word > 0) then
                    $frequency div $succ_word
                else
                    0
                    where $next_word
                    order by $prob descending
                return
                    <tr>
                        <td
                            style="border: 1px solid #dddddd; text-align: center; padding: 8px">{$has_word}</td>
                        <td
                            style="border: 1px solid #dddddd; text-align: center; padding: 8px">{$next_word}</td>
                        <td
                            style="border: 1px solid #dddddd; text-align: center; padding: 8px">{round-half-to-even($prob, 4)}</td>
                    </tr>
                
                for $i in 1 to 20
                return
                    $top20probs[$i]
            }
        </table>
    </tops>
</top20>