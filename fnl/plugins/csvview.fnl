;;; hat0uma/csvview.nvim --- nicer rendering and movement for CSV files

(local opts
       (let [bind (fn [keys mode] {1 keys : mode})]
         {:parser {:comments ["#" "//"]}
          :view {:display_mode :border}
          :keymaps {:textobject_field_inner (bind :if [:o :x])
                    :textobject_field_outer (bind :af [:o :x])
                    :jump_next_field_end (bind :<Tab> [:n :v])
                    :jump_prev_field_end (bind :<S-Tab> [:n :v])
                    :jump_next_row (bind :<Enter> [:n :v])
                    :jump_prev_row (bind :<S-Enter> [:n :v])}}))

{1 :hat0uma/csvview.nvim
 :cmd [:CsvViewEnable :CsvViewDisable :CsvViewToggle]
 : opts}
