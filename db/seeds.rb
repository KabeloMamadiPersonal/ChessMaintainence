Member.find_or_create_by!(name: 'Jane', surname: 'Doe', email: 'Janedoe@gmail.com', birthday: '1991-01-01',
                          rank: Member.where(active: true).count + 1)
Member.find_or_create_by!(name: 'Peter', surname: 'Drury', email: 'PeterDrury@gmail.com', birthday: '1991-02-01',
                          rank: Member.where(active: true).count + 1)
Member.find_or_create_by!(name: 'Mark', surname: 'Smith', email: 'MarkSmith@gmail.com', birthday: '1991-03-01',
                          rank: Member.where(active: true).count + 1)
Member.find_or_create_by!(name: 'Will', surname: 'Fax', email: 'WillFax@gmail.com', birthday: '1991-04-01',
                          rank: Member.where(active: true).count + 1)
