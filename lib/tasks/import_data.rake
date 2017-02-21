namespace :import_data do
  desc "Charge all enumeration"
  task immunization: :environment do
    file = "immunization.xlsx"
    s = SpreadsheetEnumerationUpload.new file
    s.upload_immunization_cvx
  end
 task hcpc: :environment do
   file = "HCPC.xlsx"
   s = SpreadsheetEnumerationUpload.new file
   s.upload_hcpc
  end
end