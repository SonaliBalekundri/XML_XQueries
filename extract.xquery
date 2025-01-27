<occ_has>
    <has_next
        id="hn">
        <heading>
            A. TABLE CONTAINS THE OCCURENCES OF THE WORD 'has' ALONG WITH THE WORD WHICH COMES NEXT IN THE SENTENCE
        </heading>
        <table
            style="font-family: arial, sans-serif; border-collapse: collapse; width: 10%;">
            <tr>
                <th
                    style="border: 1px solid #dddddd; text-align: center; padding: 8px; background-color: #dddddd">Target</th>
                <th
                    style="border: 1px solid #dddddd; text-align: center; padding: 8px; background-color: #dddddd">Successor</th>
            </tr>
            {
                let $files := collection("./?select=*xml")/bncDoc
                for $has in $files//w[normalize-space(lower-case(.)) = "has"]
                let $next := $has/following-sibling::w[1]
                let $has_word := normalize-space($has)
                let $next_word := normalize-space($next)
                    where $next
                return
                    <tr>
                        <td
                            style="border: 1px solid #dddddd; text-align: center; padding: 8px">{$has_word}</td>
                        <td
                            style="border: 1px solid #dddddd; text-align: center; padding: 8px">{$next_word}</td>
                    </tr>
            }
        </table>
    </has_next>
</occ_has>