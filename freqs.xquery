<distinct_values>
    <freq
        id="freq_count">
        <heading>
            B. TABLE CONTAINS ONLY UNIQUE RESULTS WITH THE FREQUENCY OF THE COMBINED WORD OCCURRED
        </heading>
        <table
            style="font-family: arial, sans-serif; border-collapse: collapse; width: 10%;">
            <tr>
                <th
                    style="border: 1px solid #dddddd; text-align: center; padding: 8px; background-color: #dddddd">Target</th>
                <th
                    style="border: 1px solid #dddddd; text-align: center; padding: 8px; background-color: #dddddd">Successor</th>
                <th
                    style="border: 1px solid #dddddd; text-align: center; padding: 8px; background-color: #dddddd">Frequency</th>
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
                
                for $unique_word in distinct-values($combined)
                let $frequency := count($combined[. = $unique_word])
                let $has_word := tokenize($unique_word, ' ')[1]
                let $next_word := tokenize($unique_word, ' ')[2]
                    order by $frequency descending
                return
                    <tr>
                        <td
                            style="border: 1px solid #dddddd; text-align: center; padding: 8px">{$has_word}</td>
                        <td
                            style="border: 1px solid #dddddd; text-align: center; padding: 8px">{$next_word}</td>
                        <td
                            style="border: 1px solid #dddddd; text-align: center; padding: 8px">{$frequency}</td>
                    </tr>
            }
        </table>
    </freq>
</distinct_values>